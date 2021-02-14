# Defined interactively
function k8s.events.list --description 'List events from a Kubernetes cluster'
    kubectl get event \
        --field-selector='reason==Created' \
        # -o custom-columns=NAME:.name \
        | cut -d "." -f1 | sort -u
end
