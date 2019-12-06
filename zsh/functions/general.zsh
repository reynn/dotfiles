# -----------------------------------------------------------------------------
# Dotfiles functions ----------------------------------------------------------

function update-dotfiles() {
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

function load-plugin() {
  antibody bundle robbyrussell/oh-my-zsh path:plugins/$1
}

# -----------------------------------------------------------------------------
# String/Printing functions ---------------------------------------------------

function print_padded() {
  local length=$1
  local string1=$2
  local pad_char=${3:-' '}

  local pad=$(printf '%0.1s' "$pad_char"{1..$length})

  printf '%s%*.*s' "$string1" 0 $(($length - ${#string1} )) "$pad"
}

function print_padded_two() {
  local length=$1
  local string1=$2
  local string2=$3
  local pad_char=${4:-' '}

  local pad=$(printf '%0.1s' "$pad_char"{1..$length})

  printf '%s%*.*s%s' "$string1" 0 $(($length - ${#string1} - ${#string2} )) "$pad" "$string2"
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
  printf "%${repeat_count}s" |tr " " "$repeat_char"
}
