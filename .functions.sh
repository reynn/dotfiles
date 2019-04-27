function kube() {
  # .kube contains the kubernetes config files
  kube_image=${KUBECTL_IMAGE:-quay.cnqr.delivery/containerhosting/kubectl}
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

