#!/bin/usr/env zsh

# -----------------------------------------------------------------------------
# FZF functions ---------------------------------------------------------------
# -----------------------------------------------------------------------------

stty stop undef
# -----------------------------------------------------------------------------
## FZF:Unix functions ---------------------------------------------------------
function fzf-ssh {
  local all_matches=$(rg "Host\s+\w+" ~/.ssh/config* | rg -v '\*')
  local only_host_parts=$(echo "$all_matches" | awk '{print $NF}')
  local selection=$(echo "$only_host_parts" | fzf --height=10 --ansi --reverse --select-1)
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
  if test -z $K8S_NAMESPACE; then
    local all_matches=$(kubectl get pods --all-namespaces -o json | jq '.items[] | {name: .metadata.name, namespace: .metadata.namespace}')
  else
    local all_matches=$(kubectl get pods --namespace $K8S_NAMESPACE -o json | jq '.items[] | {name: .metadata.name, namespace: .metadata.namespace}')
  fi
  local pod=$(echo "$all_matches" | jq -r '.name' | fzf)
  print_debug "$pod" "pod"
  local namespace=$(echo "$all_matches" | jq ". | select(.name==\"$pod\").namespace" -r)
  local container="$(kubectl get pod -n $namespace $pod -o json | jq -r '.spec.containers[].name' | fzf -1)"
  print_debug "$namespace" "namespace"
  if [ ! -z $pod ]; then
    BUFFER="kubectl logs -n $namespace -f $pod -c $container"
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
