#!/usr/bin/env bash

pad() { printf '%*s%s\n' "$(($1 - ${#2}))" "" "$2"; }
log() {
  local log_args=("$@")
  local level='info'
  local color_reset="\033[0m"
  local message="$1"
  if test ${#log_args[@]} -gt 1; then
    level="$1"
    message="$2"
  fi
  local color_level="\033[0;33m"
  case $level in
  error) color_level="\033[0;31m" ;;
  fatal) color_level="\033[0;31m" ;;
  warn) color_level="\033[0;32m" ;;
  debug) color_level="\033[0;34m" ;;
  prompt) color_level="\033[0;35m" ;;
  esac

  echo -e "$color_level[$(pad 6 $level | tr '[:lower:]' '[:upper:]')] $message$color_reset" 1>&2
  if test "$level" = 'fatal'; then
    exit 2
  fi
}

rust_check() {
  local cargo_location="${CARGO_HOME:-$HOME/.cargo}"
  if test ! -d $cargo_location; then
    log "Cargo is not found at $cargo_location"
  fi
}

python_packages() {
  log 'Installing python packages'
  log "Python installation: $(dirname $PYTHON_BINARY)"

  $PYTHON_BINARY -m pip install \
    --disable-pip-version-check \
    --no-cache-dir \
    --upgrade \
    --quiet \
    ansible-base
}

platform_mac() {
  log 'Installing Mac dependencies'
  if test -z "$BREW_BINARY"; then
    log 'Brew is not installed.'
  else
    log 'Installing brew dependencies'
    log "Brew installation: $(dirname $BREW_BINARY)"
  fi
}

platform_linux() {
  local release="$(cat /etc/*release* | grep -G '^ID=.*' | cut -d= -f2 | tr '[:upper:]' '[:lower:]' | tr -d \")"
  log "Installing Linux dependencies for $release"
  local packages=('git')
  platform_linux_apt() {
    packages+=('python3-pip')
    log "Installing [${#packages[@]}] packages with apt"
    sudo apt-get update &&
      apt-get upgrade -y &&
      echo "${packages[@]}" | xargs -l apt-get install -y
  }
  platform_linux_dnf() {
    packages+=('python3-pip' 'ncurses')
    log "Installing [${#packages[@]}] packages with dnf"
    sudo dnf update -y &&
      sudo dnf upgrade -y &&
      echo "${packages[@]}" | xargs -l sudo dnf install -y
    return $?
  }
  platform_linux_pacman() {
    packages+=('python' 'python-pip')
    log "Installing [${#packages[@]}] packages with pacman"
    # Get latest from configured pacman repos
    # Update the system packages
    sudo pacman --sync --refresh --sysupgrade &&
      echo "${packages[@]}" | xargs -l sudo pacman --noconfirm -S
  }
  case $release in
  debian) platform_linux_apt || log 'fatal' 'Failed to install packages with APT' ;;
  centos) platform_linux_dnf || log 'fatal' 'failed to install packages with DNF' ;;
  manjaro) platform_linux_pacman || log 'fatal' 'failed to install packages with Pacman' ;;
  *) log 'fatal' "Unsupported/Unknown Linux distribution $release" ;;
  esac
}

ansible_run() {
  log 'Running ansible playbook'
  ANSIBLE_CONFIG=$DFP/ansible/ansible.cfg ansible-playbook "$DFP/ansible/config.yaml" || log 'fatal' 'Failure in ansible run'
}

clone() {
  local git_command=$(command -s git)
  if test -z git_command; then
    log 'fatal' '`git` is not installed'
    exit 2
  fi
  if test ! -d $DFP; then
    if test ! -f ~/.ssh/id_rsa; then
      log 'Creating ssh key'
      ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
    fi
    log 'prompt' "Has the following public key been added to GitHub?\n\n$(cat ~/.ssh/id_rsa.pub)\n"
    read key_added
    case $key_added in
    y) log 'debug' 'Key added!' ;;
    n) log 'debug' 'Key not confirmed to be added, some commands may not work' ;;
    *) log 'error' "Unknown [$key_added]" ;;
    esac
    log "Cloning the dotfiles repo to $DFP"
    ssh-keyscan -t rsa,dsa -f github.com >>$HOME/.ssh/known_hosts
    git clone $DOTFILES_REPO $DFP
  fi
}

main() {
  log 'Installing prerequisites'
  case $PLATFORM in
  macos) platform_mac || log 'fatal' 'Failed to configure platform OS X' ;;
  darwin) platform_mac || log 'fatal' 'Failed configure platform OS X' ;;
  linux) platform_linux || log 'fatal' 'Failed configure platform Linux' ;;
  *) log 'fatal' "Unsupported/Unknown platform [$PLATFORM]" ;;
  esac
  export PATH="$HOME/.local/bin:$PATH"

  local terminal_cols=$(tput cols)

  if test -z "$PYTHON_BINARY"; then
    log 'Setting PYTHON_BINARY again'
    PYTHON_BINARY=$(command -s python3)
  fi

  log 'warn' "$(pad $(($terminal_cols - 30)) 'This is a work in progress')"
  log 'Initializing reynn/dotfiles'
  python_packages
  clone
  ansible_run

  log 'Completed!'
}

DOTFILES_REPO="git@github.com:reynn/dotfiles"
DFP=$HOME/git/github.com/reynn/dotfiles
PYTHON_BINARY=$(command -s python3)
BREW_BINARY=$(command -s brew)

if test -n "$PYTHON_BINARY"; then
  log 'debug' "Setting PLATFORM using $PYTHON_BINARY"
  PLATFORM="$($PYTHON_BINARY -m platform | cut -f1 -d- | tr '[:upper:]' '[:lower:]')"
else
  log 'debug' "Setting PLATFORM using [uname]"
  PLATFORM="$(uname | tr '[:upper:]' '[:lower:]')"
fi

main "$@"
