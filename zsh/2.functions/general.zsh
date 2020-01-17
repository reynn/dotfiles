#!/bin/usr/env zsh

# -----------------------------------------------------------------------------
# Dotfiles functions ----------------------------------------------------------
# -----------------------------------------------------------------------------

function update_dotfiles() {
  local tags="$1"
  if [ "$tags" = '-h' ]; then
    print_usage_json "$0"
    return 0
  fi
  if test -z $tags; then
    ANSIBLE_CONFIG=$DFP/ansible.cfg ansible-playbook $DFP/playbook-config.yaml
  else
    ANSIBLE_CONFIG=$DFP/ansible.cfg ansible-playbook $DFP/playbook-config.yaml --tags $tags
  fi
}

function load_plugin() {
  antibody bundle robbyrussell/oh-my-zsh path:plugins/$1
}

function import_zsh_files() {
  print_debug "zsh files from $1"
  for d in $1; do
    for f in $(fd -I -t f -H -e zsh . $d); do
      import $f
    done
  done
}

function import() {
  local sourceable="$1"
  if test -r "$sourceable"; then
    print_debug "$sourceable"
    source "$sourceable"
  fi
}

# -----------------------------------------------------------------------------
# UNIX functions --------------------------------------------------------------
# -----------------------------------------------------------------------------

function zsudo() {
  sudo -E zsh -c "$functions[$1]" "$@"
}

function mkcd() {
  mkdir -p "$@" && cd "$_"
}

function slice_arr() {
  local i=$1
  local arr=($@)
  echo ${arr[@]:${i}}
}

function tmux_connect {
  TERM=xterm-256color ssh $1 -t "tmux new-session -s ssh-sess || tmux attach-session -t ssh-sess"
}

function listen_port() {
  local port=$1
  lsof -nP -i4TCP:$port | grep LISTEN | awk '{ print $2 }'
}

function kill_listening() {
  local port=$1
  if test -z $port; then
    print_usage_json "$0"
    return 0
  fi
  local process=$(listen_port $port)

  print_info "$process" 'process_id'
  sudo kill -9 $process
}

function check_cmd() {
  test -x "$(command -v $1)"
}

function dig_ip() {
  dig +nocmd "$1" A +noall +answer | grep -v 'CNAME' | awk '{print $5}' | head -n 1
}

# Run `dig` and display the most useful info
function digga() {
  dig +nocmd "$1" any +multiline +noall +answer;
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
  if [ $# -eq 0 ]; then
    open .
  else
    open "$@"
  fi;
}

function auto_retry() {
  false
  while [ $? -ne 0 ]; do
    "$@" || (sleep 3; false)
  done
}

function ssh_auto_retry() {
  auto_retry ssh "$@"
}

function length() {
  echo "$#"
}

function bin_completion() {
  local bins=(minikube kubectl helm)
  local in=($@)
  if [ "$(length $in)" -gt "0" ]; then
    print_debug 'overriding defaults...'
    bins=($@)
  fi
  for bin in $bins; do
    print_info "Sourcing completions for $bin"
    source <($bin completion zsh)
  done
}