function aws.eks_kubeconfig.retrieve
    set -l cluster_names $cluster_name
    set -l aws_profile default
    set -l kubeconfig_path "$HOME/.kube/config"

    function ___usage
        set -l help_args -a "Interactively get kubeconfigs from AWS for EKS clusters"

        set -a help_args -f "k|kubeconfig|The kubeconfig the cluster info will be added to|"
        set -a help_args -f "n|name|Name of a cluster to get Kubeconfig for, can be provided multiple times|"
        set -a help_args -f "p|profile|AWS Profile used for auth|$aws_profile"

        __dotfiles_help $help_args
    end

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
        __log error '`aws` is not installed'
        return 1
    end

    if test -z "$aws_profile"
        set aws_profiles (aws configure list-profiles | sk --height 35% --width 60% --multi --select-1)
    end

    if test -z "$cluster_names"
        set cluster_names (aws --profile "$aws_profile" eks list-clusters | jq -r '.clusters[]' | sk --height 35% --multi --select-1)
    end

    for cluster in $cluster_names
        aws --profile "$aws_profile" eks update-kubeconfig --alias "$cluster" --name "$cluster" --kubeconfig "$kubeconfig_path"
    end
end
