#!/bin/bash -e
export GFP="$HOME/git"
export DFP="$GFP/reynn/dotfiles"

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
  color_print_fg 202 'Error'
  color_print_fg 208 '>> '
  color_print_fg 220 $@
  fg_clear
}

print_install() {
  color_print_fg 31 '>>'
  color_print_fg 33 'Install'
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
    apt-get update && apt-get install --no-install-recommends -y python3-pip git
  fi
  if check_cmd pip; then
    pip install ansible
  elif check_cmd pip3; then
    pip3 install ansible
  else
    print_error 'Pip not found'
    exit 1
  fi
  if check_cmd git; then
    print_install 'Cloning dotfiles repository...'
    git clone --depth=10 https://github.com/reynn/dotfiles.git $HOME/git/reynn/dotfiles
  else
    print_error 'Git not found'
    exit 1
  fi
}

function main() {
  if [ ! -d "$DFP" ]; then
    print_install "Handling dependencies where possible..."
    handle_deps
    print_install "Running ansible playbook..."
    ansible-playbook $DFP/playbook-config.yaml
  else
    print_install "Re-linking .zshrc..."
    ln -sfn $DFP/zsh/.zshrc $HOME/.zshrc
  fi
}

main
