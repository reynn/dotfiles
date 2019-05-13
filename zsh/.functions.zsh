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

function k8s_get_service_account_config() {
  # Add user to k8s using service account, no RBAC (must create RBAC after this script)
  if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    print_usage "$0 <sa_name> <namespace> <out_file|optional>"
    return 1
  fi
  local kubeconfig="$3"
  if test -z $kubeconfig; then
    print_info_label "K8S-SA" "Creating temp file for the kubeconfig..."
    kubeconfig="$(mktemp -t kubeconfig.yaml)"
  else
    print_debug_label "K8S-SA" "Setting permissions for $kubeconfig..."
    touch $kubeconfig
    chmod 0644 $kubeconfig
  fi

  local sa_name="$1"
  local namespace="$2"
  local sa_uri="$namespace/$sa_name"

  print_debug_label "K8S-SA" "kubeconfig file $kubeconfig"

  print_info_label "K8S-SA" "Checking for $sa_uri"

  if test -z "$(kubectl -n $namespace get sa $sa_name -o json --ignore-not-found)"; then
    print_warning_label "K8S-SA" "Creating $sa_uri, account will have no permissions by default."
    kubectl create serviceaccount -n $namespace $sa_name
  fi

  print_info_label "K8S-SA" "Getting secret..."
  local sa_secret=$(kubectl get sa "$sa_name" --namespace="$namespace" -o json | jq -r '.secrets[0].name')
  print_debug_label "K8S-SA" "name $sa_secret"

  print_info_label "K8S-SA" "Getting ca.cert..."
  local ca_crt="$(kubectl get secret --namespace $namespace $sa_secret -o json | jq -r '.data["ca.crt"]' | base64 -D)"
  local ca_crt_file="$(mktemp -t k8s_ca.crt)"
  echo $ca_crt >> $ca_crt_file
  print_debug_label "K8S-SA" "CA.crt - $ca_crt"

  print_info_label "K8S-SA" "Getting SA token..."
  local sa_token=$(kubectl get secret --namespace $namespace $sa_secret -o json | jq -r '.data["token"]' | base64 -D)
  print_debug_label "K8S-SA" "token - $sa_token"

  local context=$(kubectl config current-context)
  print_info_label "K8S-SA" "Setting context..."

  local cluster_name=$(kubectl config get-contexts "$context" | awk '{print $3}' | tail -n 1)
  print_info_label "K8S-SA" "Cluster name $cluster_name..."

  local endpoint=$(kubectl config view -o jsonpath="{.clusters[?(@.name == \"$cluster_name\")].cluster.server}")
  print_info_label "K8S-SA" "Endpoint $endpoint..."

  print_info_label "K8S-SA" "Preparing - $namespace-conf"
  print_info_label "K8S-SA" "Adding a cluster entry in kubeconfig..."
  kubectl config set-cluster "$cluster_name" \
    --kubeconfig="$kubeconfig" \
    --server="$endpoint" \
    --certificate-authority="$ca_crt_file" \
    --embed-certs=true
  print_info_label "K8S-SA" "Adding token credentials entry in kubeconfig..."
  kubectl config set-credentials \
    "$sa_name-$namespace-$cluster_name" \
    --kubeconfig="$kubeconfig" \
    --token="$sa_token"
  print_info_label "K8S-SA" "Adding a context entry in kubeconfig..."
  kubectl config set-context \
    "$sa_name-$namespace-$cluster_name" \
    --kubeconfig="$kubeconfig" \
    --cluster="$cluster_name" \
    --user="$sa_name-$namespace-$cluster_name" \
    --namespace="$namespace"
  print_info_label "K8S-SA" "Setting context in kubeconfig..."
  kubectl config use-context "$sa_name-$namespace-$cluster_name" --kubeconfig="$kubeconfig"
  print_debug_label "K8S-SA" "Deleting ca.crt temp file..."
  unlink $ca_crt_file
  if test -z $3; then
    print_debug_label "K8S-SA" "Deleting kubeconfig..."
    cat $kubeconfig
    unlink $kubeconfig;
  fi
}

# -----------------------------------------------------------------------------
# Golang functions ------------------------------------------------------------
# -----------------------------------------------------------------------------

# Change go versions
function go_ch() {
  if test -n "$1"; then
    print_info "Go $TXT_DIVIDER$FMT_INFO Running Gimme with $1"
    eval "$(gimme $1)"
  else
    print_info "Go $TXT_DIVIDER$FMT_INFO Sourcing latest Go env..."
    local env_file="$HOME/.gimme/envs/latest.env"
    if test -r $env_file; then
      source $env_file
    fi
  fi
}

# Get coverage report for testing go projects
function go_cover () {
  local t=$(mktemp -t cover)
  go test $COVERFLAGS -coverprofile=$t $@ \
    && go tool cover -func=$t \
    && unlink $t
}

# -----------------------------------------------------------------------------
# GitHub functions ------------------------------------------------------------
function get_latest_gh_assets() {
  if test -z $1; then
    print_usage "$0 <git_owner> <git_repository>"
    return 1
  fi
  local res=$(curl -Ls https://api.github.com/repos/$1/$2/releases/latest | jq '. | {tag: .tag_name, assets: [{name: .assets[].name, type: .assets[].content_type, url: .assets[].browser_download_url}]}')
  echo $res | jq '[.assets[] | select(.content_type!="text/plain") | {name: .name, type: .content_type, tag: .tag_name, url: .browser_download_url} ]'
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

function bin_completion() {
  for bin in minikube kubectl; do
    print_info "Getting completions for $bin"
    source <($bin completion zsh)
  done
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
  echo -en "$TXT_DIVIDER$FMT_USAGE Usage $TXT_DIVIDER $FMT_USAGE$@$FMT_CLEAR_ALL\n"
}

function print_usage_label() {
  echo -en "$TXT_DIVIDER$FMT_USAGE Usage $TXT_DIVIDER $FMT_USAGE$1 $TXT_DIVIDER $FMT_USAGE$2$FMT_CLEAR_ALL\n"
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
function fzf-k8s-logs {
  local all_matches=$(kubectl get pods -o name)
  local selection=$(echo "$all_matches" | fzf)
  echo $selection
  if [ ! -z $selection ]; then
    BUFFER="kubectl logs -f $selection"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-k8s-logs

function fzf-k8s-port-forward {
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
zle -N fzf-k8s-port-forward

# CTRL+F - show a list of functions and insert
function fzf-funcs {
  local func=$(functions | rg -e "^[A-Za-z].+\(\) \{$" | tr ' () {' ' ' | fzf-tmux -d 15)
  zle reset-prompt
  return $func
}
zle -N fzf-funcs
