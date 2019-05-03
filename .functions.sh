function kube() {
  # .kube contains the kubernetes config files
  local kube_image=${KUBECTL_IMAGE:-bitnami/kubectl}
  docker run --rm -v "$(pwd):/kube" -v "$HOME/.kube:/root/.kube" -w /kube $kube_image "$@"
}

function k8s_a() {
  kubectl apply -f $@
}

function k8s_dar() {
  local resources=$1
  echo "Deleting all $resources resources"
  kubectl delete $(kubectl get $resources -o name)
}

function listenport() {
  local port=$1
  lsof -nP -i4TCP:$port | grep LISTEN | awk '{ print $2 }'
}

function killlistening() {
  local port=$1
  local process=$(listenport $port)

  echo "Killing process $process"
  sudo kill -9 $process
}

function join_by { local IFS="$1"; shift; echo "$@"; }

stty stop undef
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
zle     -N     fzf-ssh

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
zle     -N     fzf-dps

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
zle     -N     fzf-kls

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
zle     -N     fzf-kspf
