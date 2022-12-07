#!/usr/bin/env fish

# --- k8s.ctx.change ---

complete -c 'k8s.ctx.change' -d 'The path containing potential Kubeconfig files' -l 'kubeconfig-path' -s 'p'
complete -c 'k8s.ctx.change' -d 'What to set KUBECTX variable to, as well as where to look for contexts' -l 'kubeconfig' -s 'k'
complete -c 'k8s.ctx.change' -d 'Remove the default and search ~/.kube for files' -l 'no-kubeconfig' -s 'K'
