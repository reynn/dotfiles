function k8s.pods.list --description 'Show a list of pods for a Kubernetes namespace' --wraps 'kubectl get pods'
    set -lx k8s_namespace default
    set -lx force false
    set -lx extra_args

    function ___usage
        set -l help_args -a "Show a list of pods for a Kubernetes namespace"
        set -a help_args -f "N|namespace|Namespace of the Kubernetes cluster to search|$k8s_namespace"
        set -a help_args -e ' -N argocd # Will show a list of containers that will be deleted'
        set -a help_args -e ' -N argocd -f # Will skip showing containers and just proceed with removal'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case N namespace
                set -x k8s_namespace "$value"
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

    __log debug "Namespace: $k8s_namespace"
    __log debug "ExtraArgs: $extra_args"

    kubectl get pods -n $k8s_namespace $extra_args
end
