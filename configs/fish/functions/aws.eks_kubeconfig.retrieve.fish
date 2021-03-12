# Defined in /var/folders/g1/yb6lm8vn30l9n0fcjck955rr0000gn/T//fish.PgqJMt/aws.eks_kubeconfig.retrieve.fish @ line 1
function aws.eks_kubeconfig.retrieve
    set -l cluster_name $cluster_name

    getopts $argv | while read -l key value
        switch $key
            case n name
                set -x cluster_name $value
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
        log.error '`aws` is not installed'
        return 1
    end

    if test -z "$cluster_name"
        set -x cluster_name (aws eks list-clusters | jq -r '.clusters[]' | fzf --select-1)
    end

    aws eks update-kubeconfig --name $cluster_name
end
