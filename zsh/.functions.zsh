FP="$DFP/zsh/.functions.zsh"

# -----------------------------------------------------------------------------
#### File Aliases -------------------------------------------------------------
alias FE="vim $FP" # alias edit
alias FR="source $FP" # alias reload

# -----------------------------------------------------------------------------
# Kubernetes functions --------------------------------------------------------
function k8s_dar() {
  local resources=$1
  echo "Deleting all $resources resources"
  kubectl delete $(kubectl get $resources -o name)
}

# -----------------------------------------------------------------------------
# Kubernetes functions --------------------------------------------------------
function get_latest_gh_assets() {
  curl -Ls https://api.github.com/repos/$1/$2/releases/latest | jq '[ .assets[] | select(.content_type!="text/plain") | {name: .name, type: .content_type, url: .browser_download_url} ]'
}

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
  local process=$(listenport $port)

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

function join_by { local IFS="$1"; shift; echo "$@"; }

# -----------------------------------------------------------------------------
## Unix:Echo functions --------------------------------------------------------
function color_print() {
  local start_color=$1
  local end_color=$2
  if [ test -z $start_color || test -z $end_color ]; then
    return
  fi
  for i in {$1..$2}; do
    color_print_fg $i "$i"
    fg_clear
  done
}

function color_print_fg() {
  local color=$1
  local arr=$(slice_arr 2 $@)
  echo -en "\e[38;5;$1m$arr\e[0m"
}

function fg_clear() {
  color_print_fg 0 "\n\e[0n"
}

function color_print_bg() {
  local color=$1
  local arr=$(slice_arr 2 $@)
  echo -en "\e[48;5;$1m$arr"
}

function bg_clear() {
  color_print_bg 0 "\n\e[0n"
}

function print_error() {
  color_print_fg 208 '>>'
  color_print_fg 202 'Error'
  color_print_fg 208 '>> '
  color_print_fg 220 "$@"
  fg_clear
}

function print_usage() {
  color_print_fg 104 '>>'
  color_print_fg 63 'Usage'
  color_print_fg 104 '>> '
  color_print_fg 63 "$@"
  fg_clear
}

# -----------------------------------------------------------------------------
# FZF functions ---------------------------------------------------------------
# -----------------------------------------------------------------------------
stty stop undef
# -----------------------------------------------------------------------------
## FZF:Unix functions ---------------------------------------------------------
function fzf-ssh {
  local all_matches=$(rg "Host\s+\w+" ~/.ssh/config* | rg -v '\*')
  local only_host_parts=$(echo "$all_matches" | awk '{print $NF}')
  local selection=$(echo "$only_host_parts" | fzf)
  echo $selection
  if [ ! -z $selection ]; then
    BUFFER="ssh $selection"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-ssh

# -----------------------------------------------------------------------------
## FZF:Docker functions -------------------------------------------------------
function fzf-dps {
  local all_matches=$(docker container ls --format '{{.Names}}')
  local selection=$(echo "$all_matches" | fzf)
  echo $selection
  if [ ! -z $selection ]; then
    BUFFER="docker logs -f $selection"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-dps

# -----------------------------------------------------------------------------
## FZF:K8S functions ----------------------------------------------------------
function fzf-kls {
  local all_matches=$(kubectl get pods -o name)
  local selection=$(echo "$all_matches" | fzf)
  echo $selection
  if [ ! -z $selection ]; then
    BUFFER="kubectl logs -f $selection"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-kls

function fzf-kspf {
  # Get all the available services
  local all_matches=$(kubectl get services --all-namespaces -o json | jq -r '.items[].metadata | {name: .name, namespace: .namespace}')
  # User selects a service by it's name
  local service_name=$(echo "$all_matches" | jq -r '.name' | fzf -1)
  # Determine the namespace the selected service is in
  local namespace=$(echo "$all_matches" | jq ". | select(.name==\"$service_name\").namespace" -r)
  # Get the available ports for the service
  local ports=$(kubectl get service --namespace $namespace -o json $service_name | jq '.spec.ports[].port')
  local port_selection=$(echo "$ports" | fzf -1 -m | paste -sd " " -)
  if [ ! -z $service_name ]; then
    # set the buffer so the next command will proceed
    BUFFER="kubectl --namespace $namespace port-forward svc/$service_name $port_selection"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-kspf

function fzf-funcs {
  local func=$(functions | rg -e "^[A-Za-z].+\(\) \{$" | tr ' () {' ' ' | fzf -1)
  BUFFER="$func"
  zle reset-prompt
}
zle -N fzf-funcs
