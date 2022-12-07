#!/usr/bin/env fish

# --- k8s.pods.delete ---

complete -c 'k8s.pods.delete' -d 'Namespace of the Kubernetes cluster to search' -l 'namespace' -s 'N'
complete -c 'k8s.pods.delete' -d 'Delete the pods without confirmation' -l 'force' -s 'f'
