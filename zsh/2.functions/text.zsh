#!/usr/bin/env zsh

function join() {
  if [ "$1" = '-h' ]; then
    print_usage_json "$0"
    return 0
  fi
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
  if [[ "$DEBUG" = "true" ]]; then
    py_print --level debug --label "$2" --name "${funcstack[2]}" "$1"
  fi
}

function print_error() {
  py_print --level error --label "$2" --name "${funcstack[2]}" "$1"
}

function print_info() {
  py_print --level info --label "$2" --name "${funcstack[2]}" "$1"
}

function print_warning() {
  py_print --level warning --label "$2" --name "${funcstack[2]}" "$1"
}

function print_usage() {
  py_print --level usage --label "$2" --name "${funcstack[2]}" "$1"
}

function print_usage_json() {
  local func_name="$1"
  if test -z "$func_name"; then func_name="${funcstack[2]}"; fi
  print_table_from_json "$HELP_JSON" --function "$func_name"
}

# -----------------------------------------------------------------------------
# String/Printing functions ---------------------------------------------------

function print_box() {
  local strings=($@)
  local header=$HEADER
  local length=${BOX_LENGTH:-100}

  echo -n '| '
  print_repeated "$(($length - 3))" '-'
  echo ' |'
  if test -n "$header"; then
    print_padded "$(($length - 1))" "| $header"
    echo ' |'
    echo -n '| '
    print_repeated "$(($length - 3))" '-'
    echo ' |'
  fi

  for s in $strings; do
    print_padded "$(($length - 1))" "| $s"
    echo ' |'
  done

  echo -n '| '
  print_repeated "$(($length - 3))" '-'
  echo ' |'
}

function print_padded() {
  local length=$1
  local string1=$2
  local pad_char=${3:-' '}

  local pad=$(printf '%0.1s' "$pad_char"{1..$length})

  printf '%s%*.*s' "$string1" 0 $(($length - ${#string1})) "$pad"
}

function print_padded_two() {
  local length=$1
  local string1=$2
  local string2=$3
  local pad_char=${4:-' '}

  local pad=$(printf '%0.1s' "$pad_char"{1..$length})

  printf '%s%*.*s%s' "$string1" 0 $(($length - ${#string1} - ${#string2})) "$pad" "$string2"
}

function longest_line_length() {
  local length=0

  for line in $@; do
    local line_length=$(str_length $line)
    if [[ $line_length -gt $length ]]; then
      length=$line_length
    fi
  done

  echo $length
}

function str_length() {
  echo "$(echo "$1" | wc -c | tr -d '[:space:]')"
}

function print_repeated() {
  local repeat_count=${1:-100}
  local repeat_char=${2:-=}
  printf "%${repeat_count}s" | tr " " "$repeat_char"
}
