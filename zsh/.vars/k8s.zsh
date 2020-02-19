#!/usr/bin/env zsh
#+============================================================================+
# K8S variables
#+============================================================================+

K8S_DEFAULT_NAMESPACE='development'
HELM_VALUES_PATH="$GFP/github.com/reynn/k8s/helm/values"

export HELM_VALUES_PATH
export K8S_DEFAULT_NAMESPACE
