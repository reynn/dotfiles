#!/usr/bin/env fish

# --- k8s.cluster.create ---

complete -c 'k8s.cluster.create' -d 'Name of the cluster' -l 'name' -s 'n'
complete -c 'k8s.cluster.create' -d 'When auto-scaling the minimum number of nodes in the cluster' -l 'min-size' -s 's'
complete -c 'k8s.cluster.create' -d 'When auto-scaling the maximum number of nodes in the cluster' -l 'max-size' -s 'S'
complete -c 'k8s.cluster.create' -d 'Size of the nodes in the cluster' -l 'node-type' -s 't'
complete -c 'k8s.cluster.create' -d 'Enable auto scaling of the cluster' -l 'auto-scale' -s 'A'
complete -c 'k8s.cluster.create' -d 'Enable one-click installs of these apps to the cluster' -l 'one-clicks' -s 'o'
complete -c 'k8s.cluster.create' -d 'Disable one-clicks for this installation' -l 'no-one-clicks' -s 'O'
complete -c 'k8s.cluster.create' -d 'Version of Kubernetes cluster' -l 'k8s-version' -s 'V'
complete -c 'k8s.cluster.create' -d 'The region of DigitalOcean to create the cluster in' -l 'do-region' -s 'R'
