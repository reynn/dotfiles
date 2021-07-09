function k8s.service.port-forward --description 'Forward an available port to a kubernetes service' --wraps 'kubectl port-forward'
    set -lx k8s_namespace default
    set -lx force false
    set -lx extra_args

    function __get_random_port
        random 2000 30000
    end

    function __get_service_name
        set -l service_names (kubectl get service -n $k8s_namespace --output json)
        echo $service_names | jq -r '.items[].metadata.name' | fzf --select-1
    end

    function __get_service_port
        set -l service_details (kubectl get service -n $k8s_namespace $service_name --output json)
        echo $service_details | jq -r '.spec.ports[].port' | fzf --select-1 --preview ""
    end

    function ___usage
        set -l help_args -a 'Forward an available port to a kubernetes service'

        set -a help_args -f "N|namespace|Namespace of the Kubernetes cluster to search|$k8s_namespace"
        set -a help_args -f 'n|service-name|The name of the service to connect to|'
        set -a help_args -f 'p|service-port|The service port to connect to|'
        set -a help_args -f 't|target-port|Where to forward the port to|random(2000, 30000)'

        set -a help_args -e ' -N argocd # Will show a list of containers that will be deleted'
        set -a help_args -e ' -N argocd -f # Will skip showing containers and just proceed with removal'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case N namespace
                set k8s_namespace "$value"
            case t target-port
                set -x local_target_port "$value"
            case n service-name
                set -x service_name "$value"
            case p service-port
                set -x pod_port_number "$value"
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

    set -q local_target_port; or set -x local_target_port (__get_random_port)
    set -q service_name; or set -x service_name (__get_service_name)
    test -n "$service_name"; or return 2 # bail out if we didn't get a service port
    set -q pod_port_number; or set -x pod_port_number (__get_service_port)

    __log debug "Namespace       : $k8s_namespace"
    __log debug "Service Name    : $service_name"
    __log debug "Target Port     : $local_target_port"
    __log debug "PodPort Number  : $pod_port_number"

    __log debug "kubectl port-forward -n $k8s_namespace $extra_args svc/$service_name $local_target_port:$pod_port_number"
    kubectl port-forward -n $k8s_namespace $extra_args svc/$service_name $local_target_port:$pod_port_number
end
