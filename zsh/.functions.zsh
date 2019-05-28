FP="$DFP/zsh/.functions.zsh"

# -----------------------------------------------------------------------------
#### File Aliases -------------------------------------------------------------
alias FE="vim $FP" # alias edit
alias FR="source $FP" # alias reload

# -----------------------------------------------------------------------------
# UNIX functions --------------------------------------------------------------

function slice_arr() {
  local i=$1
  local arr=($@)
  echo ${arr[@]:${i}}
}

function listen_port() {
  local port=$1
  lsof -nP -i4TCP:$port | grep LISTEN | awk '{ print $2 }'
}

function kill_listening() {
  local port=$1
  if test -z $port; then
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Description | Kill process listening on specified port."
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Usage       | $0 <port_number>"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Parameters  |-----------------------------------------------------"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "port_number | Port number something is listening on"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Example     | \`$0 8000\` (Force kill the process listening on port 8000)"
    return 1
  fi
  local process=$(listen_port $port)

  echo "Killing process $process"
  sudo kill -9 $process
}

function check_cmd() {
  test -r "$(which $1)"
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

function bin_completion() {
  local bins=(minikube kubectl helm)
  local in=($@)
  if [ ${#in[@]} -gt 0 ]; then
    print_debug_label "$0" "overriding defaults..."
    bins=($@)
  fi
  for bin in $bins; do
    print_info "Sourcing completions for $bin"
    source <($bin completion zsh)
  done
}

function join() {
  if [ "$1" = '-h' ]; then
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Description | array.join()."
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Usage       | $0 <var> <string> <elements>"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Parameters  |-----------------------------------------------------"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "var         | Variable to create"
    print_usage "$0" "string      | String to join on"
    print_usage "$0" "elements    | Array to join"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Example     | \`$0 joined \" and \" \"\${a[@]}\"; echo \$joined\` (one and two and three three and four and five)"
    return 1
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
  if test -z "$DEBUG"; then return; fi
  echo -en "$TXT_DIVIDER$FMT_DEBUG Debug $TXT_DIVIDER $FMT_DEBUG$@$FMT_CLEAR_ALL\n"
}

function print_debug_label() {
  if test -z "$DEBUG"; then return; fi
  echo -en "$TXT_DIVIDER$FMT_DEBUG Debug $TXT_DIVIDER $FMT_DEBUG$1 $TXT_DIVIDER $FMT_DEBUG$2$FMT_CLEAR_ALL\n"
}

function print_error() {
  echo -en "$TXT_DIVIDER$FMT_ERROR Error $TXT_DIVIDER $FMT_ERROR$@$FMT_CLEAR_ALL\n"
}
function print_error_label() {
  echo -en "$TXT_DIVIDER$FMT_ERROR Error $TXT_DIVIDER $FMT_ERROR$1 $TXT_DIVIDER $FMT_ERROR$2$FMT_CLEAR_ALL\n"
}

function print_info() {
  echo -en "$TXT_DIVIDER$FMT_INFO Info $TXT_DIVIDER $FMT_INFO$@$FMT_CLEAR_ALL\n"
}

function print_info_label() {
  echo -en "$TXT_DIVIDER$FMT_INFO Info $TXT_DIVIDER $FMT_INFO$1 $TXT_DIVIDER $FMT_INFO$2$FMT_CLEAR_ALL\n"
}

function print_warning() {
  echo -en "$TXT_DIVIDER$FMT_WARNING Warning $TXT_DIVIDER $FMT_WARNING$@$FMT_CLEAR_ALL\n"
}

function print_warning_label() {
  echo -en "$TXT_DIVIDER$FMT_WARNING Warning $TXT_DIVIDER $FMT_WARNING$1 $TXT_DIVIDER $FMT_WARNING$2$FMT_CLEAR_ALL\n"
}

function print_usage() {
  echo -en "$FMT_SET_BOLD$FMT_USAGE$1 $TXT_DIVIDER$FMT_USAGE $2$FMT_CLEAR_ALL\n"
  # echo -en "$TXT_DIVIDER$FMT_USAGE Usage $TXT_DIVIDER $FMT_USAGE$1 $TXT_DIVIDER$FMT_USAGE $2$FMT_CLEAR_ALL\n"
}
