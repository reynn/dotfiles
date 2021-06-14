function k8s.pods.delete --description 'delete pods from the specified kubernetes namespace' --wraps='kubectl delete pods'
    set -lx k8s_namespace (kubectl config get-contexts --no-headers | grep '*' | awk '{print $5}')
    set -lx force false
    set -lx extra_args

    function ___usage
        set -l help_args -a "Create a Kubernetes cluster in DigitalOcean"
        set -a help_args -f "N|namespace|Namespace of the Kubernetes cluster to search|$k8s_namespace"
        set -a help_args -f "f|force|Delete the pods without confirmation|$force"

        set -a help_args -e ' -N argocd # Will show a list of containers that will be deleted'
        set -a help_args -e ' -N argocd -f # Will skip showing containers and just proceed with removal'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case N namespace
                set -x k8s_namespace "$value"
            case f force
                set force true
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
            case "*"
                set -a extra_args $value
        end
    end

    function __k8s_delete_pods
        set -lx ns "$argv[1]"
        set -lx pods (string split ' ' "$argv[2]")
        set -lx force_delete "$argv[3]"

        log debug "[delete_pods]Force enabled: $force_delete"
        log debug "[delete_pods]Pod count: "(count $pods)
        log debug "[delete_pods]Pods to delete: $pods"

        if test "$force_delete" = true
            kubectl delete pods --namespace $ns --grace-period=0 --force $pods $extra_args
        else
            kubectl delete pods --namespace $ns $pods $extra_args
        end
    end

    function __k8s_get_pods
        set -lx ns "$argv[1]"
        kubectl get pods -n $ns --output 'jsonpath={.items[*].metadata.name}'
    end

    log debug "Namespace: $k8s_namespace"
    set -lx ns_pods (__k8s_get_pods $k8s_namespace)
    if count $ns_pods >0
        __k8s_delete_pods "$k8s_namespace" "$ns_pods" "$force"
    else
        log "Namespace [$k8s_namespace] doesn't contain any pods to delete"
    end
end
