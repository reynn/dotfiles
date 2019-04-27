function kube() {
  # .kube contains the kubernetes config files
  kube_image=${KUBECTL_IMAGE:-bitnami/kubectl}
  docker run --rm -v "$(pwd):/kube" -v "$HOME/.kube:/root/.kube" -w /kube ${kube_image} "$@"
}

function k8s_a() {
  kubectl apply -f $@
}

function k8s_dar() {
  RESOURCES=$1
  echo "Deleting all $RESOURCES resources"
  kubectl delete $(kubectl get $RESOURCES -o name)
}

function listenport() {
  PORT=$1
  lsof -nP -i4TCP:$PORT | grep LISTEN | awk '{ print $2 }'
}

function killlistening() {
  PORT=$1
  PROCESS=$(listenport $PORT)

  echo "Killing process $PROCESS"
  sudo kill -9 $PROCESS
}

stty stop undef
function fzf-ssh {
  all_matches=$(rg "Host\s+\w+" ~/.ssh/config* | rg -v '\*')
  only_host_parts=$(echo "$all_matches" | awk '{print $NF}')
  selection=$(echo "$only_host_parts" | fzf)
  echo $selection
  if [ ! -z $selection ]; then
    BUFFER="ssh $selection"
    zle accept-line
  fi
  zle reset-prompt
}
zle     -N     fzf-ssh

function fzf-dps {
  all_matches=$(docker container ls --format '{{.Names}}')
  selection=$(echo "$all_matches" | fzf)
  echo $selection
  if [ ! -z $selection ]; then
    BUFFER="docker logs -f $selection"
    zle accept-line
  fi
  zle reset-prompt
}
zle     -N     fzf-dps

function fzf-kls {
  all_matches=$(kubectl get pods -o name)
  selection=$(echo "$all_matches" | fzf)
  echo $selection
  if [ ! -z $selection ]; then
    BUFFER="kubectl logs -f $selection"
    zle accept-line
  fi
  zle reset-prompt
}
zle     -N     fzf-kls
