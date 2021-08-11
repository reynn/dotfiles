#!/usr/bin/fish

# --- k8s.service.port-forward ---

complete -c 'k8s.service.port-forward' -d 'Namespace of the Kubernetes cluster to search' -l 'namespace' -s 'N'
complete -c 'k8s.service.port-forward' -d 'The name of the service to connect to' -l 'service-name' -s 'n'
complete -c 'k8s.service.port-forward' -d 'The service port to connect to' -l 'service-port' -s 'p'
complete -c 'k8s.service.port-forward' -d 'Where to forward the port to' -l 'target-port' -s 't'
