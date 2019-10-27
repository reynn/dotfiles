# -----------------------------------------------------------------------------
# Kubernetes functions --------------------------------------------------------

function k8s_list_images() {
  kubectl get pods --all-namespaces -o jsonpath="{..image}" |\
    tr -s '[[:space:]]' '\n' |\
    sort |\
    uniq -c
}

function k8s_dar() {
  local resources=$1
  echo "Deleting all $resources resources"
  kubectl delete $(kubectl get $resources -o name)
}

function install_helm_chart() {
  if [ "$1" = '-h' ]; then
    print_usage_json "$0"
    return 0
  fi
  local all_matches=$(_get_value_files)
  local selected_chart=$(echo "$all_matches" | fzf --height=10 --ansi --reverse --select-1)
  local relative_values_file=$(realpath --relative-to=$selected_chart $PWD)
  print_debug "$0.relative_values_file" "$relative_values_file"
  local selection=$(basename $selected_chart)
  print_debug "$0.selection           " "$selection"
  local splitSelection=("${(@f)$(helpers text split -d '_' "$selection")}")

  local release_name=$(echo "$splitSelection[1]")
  local namespace=$(dirname $selected_chart | xargs basename)

  # if splitSelection > 2; then chart_repository included
  if [[ "${#splitSelection}" -eq "3" ]]; then
    print_debug "$0.if                  " "Path has a chart repository specified"
    local chart_name="$(echo $splitSelection[3] | cut -d"." -f1)"
    local chart_repository="$(echo $splitSelection[2])"
  # else; stable
  else
    print_debug "$0.if                  " "Path does not have a chart repository specified, defaulting to stable"
    local chart_name=$(echo "$splitSelection[2]" | cut -d"." -f1)
    local chart_repository="stable"
  # fi
  fi
  print_debug "$0.release_name        " "$release_name"
  print_debug "$0.namespace           " "$namespace"
  print_debug "$0.chart_repository    " "$chart_repository"
  print_debug "$0.chart_name          " "$chart_name"
  print_info "$0" "helm upgrade -i --namespace $namespace -f $relative_values_file $release_name $chart_repository/$chart_name"
  helm upgrade -i --namespace $namespace -f $relative_values_file $release_name $chart_repository/$chart_name
}

function install_helm_app() {
  local charts_folder=${1:-"$GFP/github.com/helm/charts"}
  local values_folder=${1:-"$GFP/github.com/reynn/k8s/helm/values"}
  local selected_chart=$(_get_charts $charts_folder)
  print_debug "$0.chart" "$selected_chart"
  local selected_value_file=$(_get_value_files $values_folder)
  print_debug "$0.values" "$selected_value_file"
  local namespace="$(echo $selected_value_file | cut -d'/' -f10)"
  local rel_name="$(echo $selected_value_file | cut -d'/'  -f11 | cut -d'_' -f1)"

  local args=(
    "--namespace" "$namespace"
    "-f" "$selected_value_file"
    "-n" "$rel_name"
    "$selected_chart"
  )
  print_debug "$0.args" "[[ $args ]]"

  (
    echo 'from subshell'
    sleep 3
  )

  echo $args | xargs helm template # | kapp -y deploy -a $rel_name -f -
}

function _get_charts() {
  local f=${1:-"$GFP/github.com/helm/charts"}
  print_debug "$0.folder" "$f"
  local s_c=$(fd -t f -d 3 Chart.yaml $f | \
              awk -F '[/]' '{printf "\033[01;34m%s\033[0m %s\n", $8, $9}' | \
              fzf --ansi --preview="pygmentize -P style=autumn $f/{1}/{2}/values.yaml")
  echo "$f/$(echo $s_c | tr ' ' '/')"
}

function _get_value_files() {
  local f=${1:-"$GFP/github.com/reynn/k8s/helm/values"}
  print_debug "$0.folder" "$f"
  local s_c=$(fd -t f -d 3 -e yaml . $f | \
              cut -d'/' -f10- | \
              awk -F '[/]' '{printf "\033[01;34m%s\033[0m %s\n", $1, $2}' | \
              fzf --ansi --preview="pygmentize -P style=autumn $f/{1}/{2}")
  echo "$f/$(echo $s_c | tr ' ' '/')"
}

function k8s_get_sa_config() {
  # Add user to k8s using service account, no RBAC (must create RBAC after this script)
  if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    print_usage_json "$0"
    return 0
  fi

  local kubeconfig="$3"

  if test -z $kubeconfig; then
    print_info "$0" "Creating temp file for the kubeconfig..."
    kubeconfig="$(mktemp -t kubeconfig.yaml)"
  else
    print_debug "$0" "Setting permissions for $kubeconfig..."
    touch $kubeconfig
    chmod 0644 $kubeconfig
  fi

  local sa_name="$1"
  local namespace="$2"
  local sa_uri="$namespace/$sa_name"

  print_debug "$0" "kubeconfig file $kubeconfig"

  print_info "$0" "Checking for $sa_uri"

  if test -z "$(kubectl -n $namespace get sa $sa_name -o json --ignore-not-found)"; then
    print_warning "$0" "Creating $sa_uri, account will have no permissions by default."
    kubectl create serviceaccount -n $namespace $sa_name
  fi

  print_info "$0" "Getting secret..."
  local sa_secret=$(kubectl get sa "$sa_name" --namespace="$namespace" -o json | jq -r '.secrets[0].name')
  print_debug "$0" "name $sa_secret"

  print_info "$0" "Getting ca.cert..."
  local ca_crt="$(kubectl get secret --namespace $namespace $sa_secret -o json | jq -r '.data["ca.crt"]' | base64 -D)"
  local ca_crt_file="$(mktemp -t k8s_ca.crt)"
  echo $ca_crt >> $ca_crt_file
  print_debug "$0" "CA.crt - $ca_crt"

  print_info "$0" "Getting SA token..."
  local sa_token=$(kubectl get secret --namespace $namespace $sa_secret -o json | jq -r '.data["token"]' | base64 -D)
  print_debug "$0" "token - $sa_token"

  local context=$(kubectl config current-context)
  print_info "$0" "Setting context..."

  local cluster_name=$(kubectl config get-contexts "$context" | awk '{print $3}' | tail -n 1)
  print_info "$0" "Cluster name $cluster_name..."

  local endpoint=$(kubectl config view -o jsonpath="{.clusters[?(@.name == \"$cluster_name\")].cluster.server}")
  print_info "$0" "Endpoint $endpoint..."

  print_info "$0" "Preparing - $namespace-conf"
  print_info "$0" "Adding a cluster entry in kubeconfig..."
  kubectl config set-cluster "$cluster_name" \
    --kubeconfig="$kubeconfig" \
    --server="$endpoint" \
    --certificate-authority="$ca_crt_file" \
    --embed-certs=true
  print_info "$0" "Adding token credentials entry in kubeconfig..."
  kubectl config set-credentials \
    "$sa_name-$namespace-$cluster_name" \
    --kubeconfig="$kubeconfig" \
    --token="$sa_token"
  print_info "$0" "Adding a context entry in kubeconfig..."
  kubectl config set-context \
    "$sa_name-$namespace-$cluster_name" \
    --kubeconfig="$kubeconfig" \
    --cluster="$cluster_name" \
    --user="$sa_name-$namespace-$cluster_name" \
    --namespace="$namespace"
  print_info "$0" "Setting context in kubeconfig..."
  kubectl config use-context "$sa_name-$namespace-$cluster_name" --kubeconfig="$kubeconfig"
  print_debug "$0" "Deleting ca.crt temp file..."
  unlink $ca_crt_file
  if test -z $3; then
    print_debug "$0" "Deleting kubeconfig..."
    cat $kubeconfig
    unlink $kubeconfig;
  fi
}

# -----------------------------------------------------------------------------
# Minikube functions ----------------------------------------------------------

function new_minikube() {
  local k8s_version="1.16.0"
  local memory="${2:-4}"
  if [ "$1" = '-h' ]; then
    print_usage "$0" "
    ------------------------------------------------------------------
    Description | Create a new Minikube cluster with provided settings.
    ------------------------------------------------------------------
    Usage       | $0 <kubernetes_version> <memory>
    ------------------------------------------------------------------
    Parameters  |-----------------------------------------------------
    ------------------------------------------------------------------
    k8s_version | Version of Kubernetes to use. (Default: 1.16.0)
    memory      | Amount of memory to start Minikube with, in Gb. (Default: 4Gb)
    ------------------------------------------------------------------
    Example     | \`$0 1.15.0 3\` (Start Minikube with 3Gb RAM on K8S v1.16.0)"
    return 0
  elif test -n "$1"; then
    echo "k8s_version $k8s_version"
    k8s_version="$1"
  fi
  memory="$(($memory*1024))"

  print_info "$0" "Checking for existing minikube..."
  if test $(minikube status --format '{{.Host}}'); then
    print_info "$0" "Deleting existing minikube..."
    minikube stop
    minikube delete
  fi

  print_info "$0" "Creating new minikube instance <k8s_version:$k8s_version> <memory:$memory>..."

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
