# Defined interactively
function k8s.events.list --description 'List events from a Kubernetes cluster'
    set -lx NAMESPACE --all-namespaces

    function ___usage
        set -l help_args -a "List events from a Kubernetes cluster"

        set -a help_args -f "n|namespace|Namespace to check events|$NAMESPACE"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case n namespace
                set NAMESPACE --namespace $value
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
        end
    end

    kubectl get event $NAMESPACE \
        --field-selector='reason==Created' \
        # -o custom-columns=NAME:.name \
        | cut -d "." -f1 | sort -u
end
