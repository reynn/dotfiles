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
    print_usage_json "$0"
    return 0
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

function length() {
  local in=($@)
  echo "${#in[@]}"
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
  if test -z "$DEBUG"; then return; fi
  echo -en "$DEBUG_TXT_DIVIDER\
$FMT_DEBUG \
Debug \
$DEBUG_TXT_DIVIDER \
$FMT_DEBUG\
$funcstack[2]$2 \
$DEBUG_TXT_DIVIDER \
$FMT_DEBUG\
$1\
$FMT_CLEAR_ALL\n"
}

function print_error() {
  echo -en "$ERROR_TXT_DIVIDER\
$FMT_ERROR \
Error \
$ERROR_TXT_DIVIDER \
$FMT_ERROR\
$funcstack[2]$2 \
$ERROR_TXT_DIVIDER \
$FMT_ERROR\
$1\
$FMT_CLEAR_ALL\n"
}

function print_info() {
  echo -en "$INFO_TXT_DIVIDER\
$FMT_INFO \
Info \
$INFO_TXT_DIVIDER \
$FMT_INFO\
$funcstack[2]$2 \
$INFO_TXT_DIVIDER \
$FMT_INFO\
$1\
$FMT_CLEAR_ALL\n"
}

function print_warning() {
  echo -en "$WARNING_TXT_DIVIDER\
$FMT_WARNING \
Warning \
$WARNING_TXT_DIVIDER \
$FMT_WARNING\
$funcstack[2]$2 \
$WARNING_TXT_DIVIDER \
$FMT_WARNING\
$1\
$FMT_CLEAR_ALL\n"
}

function get-help() {
  local func_name=$1
  if test -z $func_name; then func_name=$(cat $HELP_JSON | jq -r 'keys | .[]' | fzf -1); fi
  print_usage_json "$func_name"
}

function print_usage_json() {
  local func_name="$1"
  if test -z "$func_name"; then func_name="$funcstack[2]"; fi
  print_table_from_json "$HELP_JSON" --function "$func_name"
}
