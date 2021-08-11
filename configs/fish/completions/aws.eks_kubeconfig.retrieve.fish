#!/usr/bin/fish

# --- aws.eks_kubeconfig.retrieve ---

complete -c 'aws.eks_kubeconfig.retrieve' -d 'An alias for the context name that is put in the Kubeconfig file' -l 'alias' -s 'a'
complete -c 'aws.eks_kubeconfig.retrieve' -d 'The kubeconfig the cluster info will be added to' -l 'kubeconfig' -s 'k'
complete -c 'aws.eks_kubeconfig.retrieve' -d 'Name of a cluster to get Kubeconfig for, can be provided multiple times' -l 'name' -s 'n'
complete -c 'aws.eks_kubeconfig.retrieve' -d 'AWS Profile used for auth' -l 'profile' -s 'p'
complete -c 'aws.eks_kubeconfig.retrieve' -d 'Add a prefix to the context name that is put in the Kubeconfig file' -l 'prefix' -s 'P'
