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
    print_usage_json "$(get-help $0)"
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

function bin_completion() {
  local bins=(minikube kubectl helm)
  local in=($@)
  if [ ${#in[@]} -gt "0" ]; then
    print_debug "$0" "overriding defaults..."
    bins=($@)
  fi
  for bin in $bins; do
    print_info "Sourcing completions for $bin"
    source <($bin completion zsh)
  done
}

function join() {
  if [ "$1" = '-h' ]; then
    print_usage_json "$(get-help $0)"
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
  echo -en "$TXT_DIVIDER$FMT_DEBUG Debug $TXT_DIVIDER $FMT_DEBUG$1 $TXT_DIVIDER $FMT_DEBUG$2$FMT_CLEAR_ALL\n"
}

function print_error() {
  echo -en "$TXT_DIVIDER$FMT_ERROR Error $TXT_DIVIDER $FMT_ERROR$1 $TXT_DIVIDER $FMT_ERROR$2$FMT_CLEAR_ALL\n"
}

function print_info() {
  echo -en "$TXT_DIVIDER$FMT_INFO Info $TXT_DIVIDER $FMT_INFO$1 $TXT_DIVIDER $FMT_INFO$2$FMT_CLEAR_ALL\n"
}

function print_warning() {
  echo -en "$TXT_DIVIDER$FMT_WARNING Warning $TXT_DIVIDER $FMT_WARNING$1 $TXT_DIVIDER $FMT_WARNING$2$FMT_CLEAR_ALL\n"
}

function print_usage() {
  echo -en "$FMT_SET_BOLD$FMT_USAGE$1 $TXT_DIVIDER$FMT_USAGE $2$FMT_CLEAR_ALL\n"
}

function print_usage_json() {
  local name="$(echo $1 | jq -r '.name')"
  local description="$(echo $1 | jq -r '.description')"
  local usage="$(echo $1 | jq -r '.usage')"
  local example_commands=$(echo $1 | jq -r '.examples[] | "\(.command)"')
  local example_descriptions=$(echo $1 | jq -r '.examples[] | "\(.description)"')
  local example_count="$(echo $1 | jq -r '.examples | length')"
  local parameters_count="$(echo $1 | jq -r '.parameters | length')"

  print_debug "example_count : $example_count || parameters_count : $parameters_count"

  local header_length=$(longest_line_length ${(f)example_commands})
  if (( $header_length < 10 )); then header_length=15; fi
  local content_length=$(longest_line_length $description $name $usage $name ${(f)example_descriptions})
  local line_length="$(( $header_length + $content_length ))"

  local examples=$(echo $1 | jq '.examples[] | {command,description}')

  echo -n "$FMT_SET_BOLD$FMT_USAGE"
  str_repeat $line_length '-'; printf '\n'
  print_padded $header_length "Name"; printf ' | %s\n' $name

  str_repeat $line_length '-'; printf '\n'
  print_padded $header_length "Description"; printf ' | %s\n' $description

  str_repeat $line_length '-'; printf '\n'
  print_padded $header_length "Usage"; printf ' | %s\n' $usage

  if [[ "$parameters_count" -gt "0" ]]; then
    str_repeat $line_length '-'; printf '\n'
    print_padded $header_length "Parameters"; printf ' | %s\n' $(str_repeat $(( $content_length - 3 )) '-')
    str_repeat $line_length '-'; printf '\n'
    echo $1 | jq -r '.parameters[] | [.name, .description] | @tsv' | awk -v FS='\t' "{ printf \"%${header_length}s | %s\n\", \$1, \$2 }"
  fi

  if [[ "$example_count" -gt "0" ]]; then
    str_repeat $line_length '-'; printf '\n'
    print_padded $header_length "Examples"; printf ' | %s\n' $(str_repeat $(( $content_length - 3 )) '-')
    str_repeat $line_length '-'; printf '\n'
    echo $1 | jq -r '.examples[] | [.command, .description] | @tsv' | awk -v FS='\t' "{ printf \"%${header_length}s | %s\n\", \$1, \$2 }"
  fi
  str_repeat $line_length '-'; printf "$FMT_CLEAR_ALL\n"
}

function get-help() {
  local func_name=$1
  if test -z $func_name; then echo 'Must provide a function name'; return 1; fi
  cat $DFP/zsh/function_help.json | jq ".[] | select(.name==\"$func_name\")"
}
