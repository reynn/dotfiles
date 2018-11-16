function kube() {
  # .kube contains the kubernetes config files
  docker run --rm -v "$(pwd):/kube" -v "$HOME/.kube:/root/.kube" -w /kube quay.cnqr.delivery/containerhosting/kubectl "$@"
}

function helm() {
  # .appr is for HELM application registry
  # .helm contains the helm configs
  # .kube contains the kubernetes config files
  docker run --rm -v "$(pwd):/helm" -v "$HOME/.appr:/root/.appr" -v "$HOME/.helm:/root/.helm" -v "$HOME/.kube:/root/.kube" -w /helm quay.cnqr.delivery/containerhosting/helm-client:v2.7.2-appr-template "$@"
}