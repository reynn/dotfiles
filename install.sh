#!/bin/bash -e
export GFP="$HOME/git"
export DFP="$GFP/github.com/reynn/dotfiles"

# -----------------------------------------------------------------------------
# Helper functions ------------------------------------------------------------
slice_arr() {
  local i=$1
  local arr=($@)
  echo ${arr[@]:${i}}
}

color_print_fg() {
  local color=$1
  local arr=$(slice_arr 2 $@)
  echo -en "\e[38;5;$1m$arr\e[0m"
}

fg_clear() {
  color_print_fg 0 "\n\e[0n"
}

print_error() {
  color_print_fg 208 '>>'
  color_print_fg 202 'error'
  color_print_fg 208 '>> '
  color_print_fg 220 $@
  fg_clear
}

print_installing() {
  color_print_fg 31 '>>'
  color_print_fg 33 'installing'
  color_print_fg 31 '>>'
  color_print_fg 183 $@
  fg_clear
}

check_cmd() {
  test -r "$(which $1)"
}

check_file() {
  test -r "$1"
}

handle_deps() {
  if check_file /etc/debian_version; then
    print_installing 'packages required for this script and ansible for debian machine...'
    apt-get update
    apt-get install --no-install-recommends -y \
        python3-{dev,pip,wheel,setuptools} \
        build-essential \
        git
  fi
  if !(check_cmd ansible); then
    if check_cmd pip; then
      print_installing 'ansible using pip...'
      pip install ansible
    elif check_cmd pip3; then
      print_installing 'ansible using pip3...'
      pip3 install ansible
    else
      print_error 'pip not found'
      exit 1
    fi
  fi
  if check_cmd git; then
    print_installing 'dotfiles repository...'
    git clone --depth=10 https://github.com/reynn/dotfiles.git $HOME/git/reynn/dotfiles
  else
    print_error 'Git not found'
    exit 1
  fi
}

function main() {
  if [ ! -d "$DFP" ]; then
    print_installing "dependencies..."
    handle_deps
    print_installing "ansible configuration..."
    mkdir -p "$HOME/.bins"
    export PATH="$HOME/.bins:$PATH"
    ANSIBLE_CONFIG=$DFP/ansible.cfg ansible-playbook $DFP/playbook-config.yaml
    ln -sfn $DFP/.zshrc $HOME/.zshrc
  else
    print_installing "re-linking .zshrc..."
    ln -sfn $DFP/.zshrc $HOME/.zshrc
  fi
}

main
