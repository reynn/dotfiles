#!/usr/bin/env zsh

# -----------------------------------------------------------------------------
# FZF functions ---------------------------------------------------------------
# -----------------------------------------------------------------------------

stty stop undef
# -----------------------------------------------------------------------------
## FZF:Unix functions ---------------------------------------------------------
function fzf-ssh() {
  local all_matches=$(rg "Host\s+\w+" ~/.ssh/config ~/.ssh/config.d/* | rg -v '\*' | awk '{print $NF}')
  local selection=$(echo "$all_matches" | fzf --height=10 --ansi --reverse --select-1)
  echo $selection
  if [ ! -z $selection ]; then
    BUFFER="ssh $selection"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-ssh

# CTRL+F - show a list of functions and insert
function fzf-funcs() {
  LBUFFER="$(functions | rg -e "^[A-Za-z].+\(\) \{$" | awk '{print $1}' | fzf-tmux -d 15)"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle -N fzf-funcs

# -----------------------------------------------------------------------------
## FZF:Docker functions -------------------------------------------------------
function fzf-dps() {
  local all_matches=$(docker container ls -a --format '{{.Names}}')
  local selection=$(echo "$all_matches" | fzf-tmux --height 40% --layout=reverse --border)
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
function fzf-k8s-logs() {
  if test -z $K8S_DEFAULT_NAMESPACE; then
    print_debug 'Getting pods from all namespaces'
    local all_matches=$(kubectl get pods --all-namespaces -o custom-columns=name:.metadata.name,namespace:.metadata.namespace)
  else
    print_debug "Getting pods from the $K8S_DEFAULT_NAMESPACE namespace"
    local all_matches=$(kubectl get pods --namespace "$K8S_DEFAULT_NAMESPACE" -o custom-columns=name:.metadata.name,namespace:.metadata.namespace)
  fi
  print_debug "Found ${#all_matches} pods"
  local pod=$(echo "$all_matches" | awk '{print $1}' | fzf --select-1 --header-lines=1)
  print_debug "$pod" "pod"
  local namespace=$(echo "$all_matches" | grep $pod | awk '{print $2}')
  local container="$(kubectl get pod -n $namespace $pod -o jsonpath='{.spec.containers[].name}' | fzf --select-1)"
  print_debug "$namespace" "namespace"
  if [ ! -z $pod ]; then
    BUFFER="kubectl logs -n $namespace -f $pod -c $container"
    echo $BUFFER
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-k8s-logs

function fzf-k8s-port-forward() {
  # Get all the available services
  local all_matches=$(kubectl get services --all-namespaces -o custom-columns=name:.metadata.name,namespace:.metadata.namespace)
  # User selects a service by it's name
  local service_info=$(echo "$all_matches" | fzf --header-lines 1 --select-1)
  local service_name=$(echo "$service_info" | awk '{print $1}')
  # Determine the namespace the selected service is in
  local namespace=$(echo "$service_info" | awk '{print $2}')
  # Get the available ports for the service
  local ports=$(kubectl get service -o jsonpath='{.spec.ports[].port}' --namespace $namespace $service_name)
  local port_selection=$(echo "$ports" | fzf -1 -m | paste -sd " " -)
  if [ ! -z $service_name ]; then
    # set the buffer so the next command will proceed
    BUFFER="kubectl --namespace $namespace port-forward svc/$service_name $port_selection"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-k8s-port-forward
