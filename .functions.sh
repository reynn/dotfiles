function kube() {
  # .kube contains the kubernetes config files
  kube_image=${KUBECTL_IMAGE:-quay.cnqr.delivery/containerhosting/kubectl}
  docker run --rm -v "$(pwd):/kube" -v "$HOME/.kube:/root/.kube" -w /kube ${kube_image} "$@"
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

function helm() {
  # .appr is for HELM application registry
  # .helm contains the helm configs
  # .kube contains the kubernetes config files
  helm_image=${HELM_IMAGE:-quay.cnqr.delivery/containerhosting/helm-client:v2.7.2-appr-template}
  docker run --rm -v "$(pwd):/helm" -v "$HOME/.appr:/root/.appr" -v "$HOME/.helm:/root/.helm" -v "$HOME/.kube:/root/.kube" -w /helm $helm_image "$@"
}
