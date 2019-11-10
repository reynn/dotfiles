FP="$DFP/zsh/.functions.zsh"

# -----------------------------------------------------------------------------
#### File Aliases -------------------------------------------------------------
alias FE="vim $FP" # alias edit
alias FR="source $FP" # alias reload

# -----------------------------------------------------------------------------
# UNIX functions --------------------------------------------------------------

function zsudo() {
  sudo zsh -c "$functions[$1]" "$@"
}

function slice_arr() {
  local i=$1
  local arr=($@)
  echo ${arr[@]:${i}}
}

function tmux-connect {
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

  echo "Killing process $process"
  sudo kill -9 $process
}

function check_cmd() {
  test -x "$(command -v $1)"
}

function dig_ip() {
  dig +nocmd "$1" A +noall +answer | grep -v 'CNAME' | awk '{ print $5 }' | head -n 1
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
    "$@" || (sleep 1;false)
  done
}

function ssh_auto_retry() {
  auto-retry ssh "$@"
}

function length() {
  echo "$#"
}

function bin_completion() {
  local bins=(minikube kubectl helm)
  local in=($@)
  if [ "$(length $in)" -gt "0" ]; then
    print_debug "overriding defaults..."
    bins=($@)
  fi
  for bin in $bins; do
    print_info "Sourcing completions for $bin"
    source <($bin completion zsh)
  done
}

function join() {
  if [ "$1" = '-h' ]; then
    print_usage_json "$0"
    return 0
  fi
  # $1 is return variable name
  # $2 is sep
  # $3... are the elements to join
  local var=$1 sep=$2 ret=$3
  shift 3 || shift $(($#))
  printf -v "$var" "%s" "$ret${@/#/$sep}"
}

function join_by() {
  local IFS="$1"
  shift
  echo "$@"
}

# -----------------------------------------------------------------------------
## Unix:Echo functions --------------------------------------------------------

function print_debug() {
  if test -n "$DEBUG"; then
    py_print --level debug --label "$1" --name "$funcstack[2]" "$2"
  fi
}

function print_error() {
  py_print --level error --label "$1" --name "$funcstack[2]" "$2"
}

function print_info() {
  py_print --level info --label "$1" --name "$funcstack[2]" "$2"
}

function print_warning() {
  py_print --level warning --label "$1" --name "$funcstack[2]" "$2"
}

function print_usage_json() {
  local func_name="$1"
  if test -z "$func_name"; then func_name="$funcstack[2]"; fi
  print_table_from_json "$HELP_JSON" --function "$func_name"
}
