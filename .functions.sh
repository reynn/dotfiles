function kube() {
  # .kube contains the kubernetes config files
  kube_image=${KUBECTL_IMAGE:-quay.cnqr.delivery/containerhosting/kubectl}
  docker run --rm -v "$(pwd):/kube" -v "$HOME/.kube:/root/.kube" -w /kube ${kube_image} "$@"
}

function helm() {
  # .appr is for HELM application registry
  # .helm contains the helm configs
  # .kube contains the kubernetes config files
  helm_image=${HELM_IMAGE:-quay.cnqr.delivery/containerhosting/helm-client:v2.7.2-appr-template}
  docker run --rm -v "$(pwd):/helm" -v "$HOME/.appr:/root/.appr" -v "$HOME/.helm:/root/.helm" -v "$HOME/.kube:/root/.kube" -w /helm $helm_image "$@"
}
