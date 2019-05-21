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

function install_helm_chart() {
  local values_path=`echo ${HELM_VALUES_PATH:-"$DFP/k8s/helm/values"}`
  local all_matches=$(find $values_path -type f -name "*$1*.yaml")
  local selected_chart=$(echo "$all_matches" | fzf)
  local relative_values_file=$(realpath --relative-to=$selected_chart $PWD)
  print_debug_label "$0.relative_values_file" "$relative_values_file"
  local selection=$(basename $selected_chart)
  local splitSelection=("${(@f)$(helpers text split -d '_' "$selection")}")
  print_debug_label "$0.selection" "$selection"

  local release_name=$(echo "$splitSelection[1]")
  local namespace=$(dirname $selected_chart | xargs basename)

  # if splitSelection > 2; then chart_repository included
  if [ ${#splitImageName[@]} -gt 2 ]; then
    tag="${splitImageName[2]}"
    local chart_name="$(echo $splitSelection[3] | cut -d"." -f1)"
    local chart_repository="$(echo $splitSelection[2])"
  # else; stable
  else
    local chart_name=$(echo "$splitSelection[2]" | cut -d"." -f1)
    local chart_repository="stable"
  # fi
  fi
  print_debug_label "$0.release_name" "$release_name"
  print_debug_label "$0.namespace" "$namespace"
  print_debug_label "$0.chart_repository" "$chart_repository"
  print_debug_label "$0.chart_name" "$chart_name"
  echo "helm upgrade -i --namespace $namespace -f $relative_values_file $release_name $chart_repository/$chart_name"
}

function k8s_get_service_account_config() {
  # Add user to k8s using service account, no RBAC (must create RBAC after this script)
  if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Description | Get a Kubeconfig.yaml for the specified Service account. Creates account if it doesn't exist."
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Usage       | $0 <sa_name> <namespace> <out_file>"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "sa_name     | Name of a K8S service account. Will be created if it doesn't exist."
    print_usage "$0" "namespace   | Namespace the service account should exist in."
    print_usage "$0" "out_file    | Where to write the kubeconfig to, will output to stdout if not set."
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Example     | \`$0 example-sa\` (Retag test-image to quay.io/reynn/test-image:dev)"
    print_usage "$0" "Example     | \`$0 example-sa development\` (Create SA example-sa in the development namespace)"
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
# Docker functions ------------------------------------------------------------

function docker_retag_and_push() {
  local image=$1
  if test -z $image; then
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Description | Retag a Docker image with the provided tag and registry."
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Usage       | $0 <image> <tag> <registry>"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "image       | Name of an image to retag"
    print_usage "$0" "tag         | New tag name (Default: dev)"
    print_usage "$0" "registry    | The registry to push to (Default: quay.io/reynn)"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Example     | \`$0 test-image\`          (Retag test-image to quay.io/reynn/test-image:dev)"
    print_usage "$0" "Example     | \`$0 test-image:snapshot\` (Retag test-image:snapshot to quay.io/reynn/test-image:dev)"
    return 1
  fi
  local tag="${2:-dev}"
  local registry="${3:-quay.io/reynn}"
  # split
  local splitImageName=("${(@f)$(helpers text split -d ':' "$image")}")
  # length
  if [ ${#splitImageName[@]} -eq 2 ]; then
    tag="${splitImageName[2]}"
  fi
  print_info_label "$0" "Retagging $image:$tag to $registry/$image:$tag"
  # docker tag "$image" "$registry/$image:$tag"
}

# -----------------------------------------------------------------------------
# Minikube functions ----------------------------------------------------------

function new_minikube() {
  local k8s_version="1.14.1"
  local memory="${2:-4}"
  if [ "$1" = '-h' ]; then
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Description | Create a new Minikube cluster with provided settings."
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Usage       | $0 <kubernetes_version> <memory>"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "k8s_version | Version of Kubernetes to use. (Default: 1.14.1)"
    print_usage "$0" "memory      | Amount of memory to start Minikube with, in Gb. (Default: 4Gb)"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Example     | \`$0 1.14.1 3\` (Start Minikube with 3Gb RAM on K8S v1.14.1)"
    return 0
  elif test -n "$1"; then
    echo "k8s_version $k8s_version"
    k8s_version="$1"
  fi
  memory="$(($memory*1024))"

  print_info_label "$0" "Checking for existing minikube..."
  if test $(minikube status --format '{{.Host}}'); then
    print_info_label "$0" "Deleting existing minikube..."
    minikube stop
    minikube delete
  fi

  print_info_label "$0" "Creating new minikube instance <k8s_version:$k8s_version> <memory:$memory>..."

  minikube start \
    --kubernetes-version=v$k8s_version \
    --memory=$memory \
    --bootstrapper=kubeadm \
    --extra-config=kubelet.authentication-token-webhook=true \
    --extra-config=kubelet.authorization-mode=Webhook \
    --extra-config=scheduler.address=0.0.0.0 \
    --extra-config=controller-manager.address=0.0.0.0 \
    --vm-driver hyperkit
}

# -----------------------------------------------------------------------------
# Golang functions ------------------------------------------------------------

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
  local owner=$1
  local repo=$2
  local host=${3:-api.github.com}

  if test -z $1; then
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Description | Create a new Minikube cluster with provided settings."
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Usage       | $0 <owner> <repo> <host>"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "owner       | The owner of the repository in GitHub"
    print_usage "$0" "repo        | The repository to get assets from"
    print_usage "$0" "host        | The API url to check. (Default: api.github.com)"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Example     | \`$0 stedolan jq\` (Get the assets for the most recent JQ release in GitHub)"
    print_usage "$0" "Example     | \`$0 stedolan jq api.github.enterprise.com\` (Get the latest assets from GCPD in Github Enterprise)"
    return 1
  fi
  helpers gh get --owner $owner --host $host --repo $repo asset --all
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
  if test -z $port; then
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Description | Kill process listening on specified port."
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Usage       | $0 <port_number>"
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
  if test -n $K8S_NAMESPACE; then
    local all_matches=$(kubectl get pods --all-namespaces -o json | jq '.items[] | {name: .metadata.name, namespace: .metadata.namespace}')
  else
    local all_matches=$(kubectl get pods --namespace $K8S_NAMESPACE -o json | jq '.items[] | {name: .metadata.name, namespace: .metadata.namespace}')
  fi
  local selection=$(echo "$all_matches" | jq -r '.name' | fzf)
  print_debug_label "$0.selection" "$selection"
  local namespace=$(echo "$all_matches" | jq ". | select(.name==\"$selection\").namespace" -r)
  print_debug_label "$0.namespace" "$namespace"
  if [ ! -z $selection ]; then
    BUFFER="kubectl logs -n $namespace -f $selection"
    echo $BUFFER
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
