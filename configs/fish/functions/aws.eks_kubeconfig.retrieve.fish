function aws.eks_kubeconfig.retrieve
    set -l cluster_names $cluster_name
    set -l aws_profile default
    set -l kubeconfig_path "$HOME/.kube/config"

    getopts $argv | while read -l key value
        switch $key
            case k kubeconfig
                set kubeconfig_path $value
            case n name
                set -a cluster_names $value
            case p profile
                set aws_profile $value
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

    if not command.is_available -c aws
        log error '`aws` is not installed'
        return 1
    end

    if test -z "$cluster_names"
        set cluster_names (aws --profile "$aws_profile" eks list-clusters | jq -r '.clusters[]' | sk --height 35% --multi --select-1)
    end

    for cluster in $cluster_names
        aws --profile "$aws_profile" eks update-kubeconfig --alias "$cluster" --name "$cluster" --kubeconfig "$kubeconfig_path"
    end
end
