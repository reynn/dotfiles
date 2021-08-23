function aws.eks_kubeconfig.retrieve
    set cluster_names
    set aws_profile
    set alias
    set alias_prefix
    set all_clusters false
    set kubeconfig_path "$HOME/.kube/config"

    function ___usage
        set -l help_args -a "Interactively get kubeconfigs from AWS for EKS clusters"

        set -a help_args -f "|all-clusters|Retrieve Kubeconfigs for all clusters without prompt|$all_clusters"
        set -a help_args -f "|all-profiles|Retrieve Kubeconfigs for all AWS profiles without prompt|$all_profiles"
        set -a help_args -f "a|alias|An alias for the context name that is put in the Kubeconfig file|<cluster_name>"
        set -a help_args -f "k|kubeconfig|The kubeconfig the cluster info will be added to|$kubeconfig_path"
        set -a help_args -f "n|name|Name of a cluster to get Kubeconfig for, can be provided multiple times|[]"
        set -a help_args -f "p|profile|AWS Profile used for auth|$aws_profile"
        set -a help_args -f "P|prefix|Add a prefix to the context name that is put in the Kubeconfig file|<cluster_name>"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case a alias
                set alias $value
            case all-clusters
                set all_clusters true
            case all-profiles
                set all_profiles true
            case k kubeconfig
                set kubeconfig_path $value
            case n name
                set -a cluster_names $value
            case p profile
                set aws_profile $value
            case P prefix
                set alias_prefix $value
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
        set aws_profile (aws configure list-profiles | sk --height 40% --multi --select-1)
    end

    if test -z "$cluster_names"
        set -x cluster_names (aws --profile "$aws_profile" eks list-clusters |\
            dasel select --plain -r json -m '.clusters.[*]')
        if test "$all_clusters" != true
            set cluster_names (echo $cluster_names | sk --height 40% --multi --select-1)
        end
    end

    __log debug "Getting kubeconfig for "(count $cluster_names)" clusters"

    for cluster in $cluster_names
        set cluster_alias
        if test -z $alias
            set cluster_alias "$cluster"
        end
        if test -n $alias_prefix
            set cluster_alias "$alias_prefix/$cluster_alias"
        end
        __log debug "Using cluster alias $cluster_alias"
        aws --profile "$aws_profile" eks update-kubeconfig --alias "$cluster_alias" --name "$cluster" --kubeconfig "$kubeconfig_path"
    end
end
