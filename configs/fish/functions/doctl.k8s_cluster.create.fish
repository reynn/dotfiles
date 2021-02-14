#!/usr/bin/env fish

function doctl.k8s_cluster.create -d 'Create a Kubernetes cluster in DigitalOcean' --wraps='doctl kubernetes cluster create'
    set -lx doctl_args
    set -x cluster_name
    set -x min_size 1
    set -x max_size 5
    set -x node_type s-2vcpu-4gb
    set -x auto_scale true
    set -x one_clicks monitoring
    set -x k8s_version latest
    set -x do_region sfo3

    function ___usage
        set -l help_args -a "Create a Kubernetes cluster in DigitalOcean"

        set -a help_args -f "n|name|Name of the cluster|$cluster_name"
        set -a help_args -f "s|min-size|When auto-scaling the minimum number of nodes in the cluster|$min_size"
        set -a help_args -f "S|max-size|When auto-scaling the maximum number of nodes in the cluster|$max_size"
        set -a help_args -f "t|node-type|Size of the nodes in the cluster|$node_type"
        set -a help_args -f "A|auto-scale|Enable auto scaling of the cluster|$auto_scale"
        set -a help_args -f "o|one-clicks|Enable one-click installs of these apps to the cluster|$one_clicks"
        set -a help_args -f "O|no-one-clicks|Disable one-clicks for this installation|"
        set -a help_args -f "V|k8s-version|Version of Kubernetes cluster|$k8s_version"
        set -a help_args -f "R|do-region|The region of DigitalOcean to create the cluster in|$do_region"

        set -a help_args -e ' -n nonprod-cluster-formidable --min-size 3 --max-size 10'
        set -a help_args -e ' -n prod-cluster-ayanami --min-size 30 --max-size 100 --node-type m3-4vcpu-32gb'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case n name
                set -x cluster_name "$value"
            case s min-size
                set -x min_size "$value"
            case S max-size
                set -x max_size "$value"
            case A auto-scale
                set auto_scale true
            case o one-clicks
                set -x -a one_clicks "$value"
            case O no-one-clicks
                set -e one_clicks
            case R do-region
                set -x do_region "$value"
            case t node-type
                set -x node_type "$value"
            case V k8s-version
                set -x k8s_version "$value"
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

    if test ! -x (command -s doctl)
        log.error "`doctl` is not available on this system"
        return 1
    end

    if test -z "$cluster_name"
        set cluster_name (__get_random_name)
    else
        set doctl_args[1] $cluster_name
    end

    if test "$min_size" = "$max_size"
        set auto_scale false
    end

    set -lx node_pool "'name=$cluster_name-worker-pool;size=$node_type;min-nodes=$min_size;max-nodes=$max_size;auto-scale=true'"

    log.debug "cluster_name : $cluster_name"
    log.debug "min_size     : $min_size"
    log.debug "max_size     : $max_size"
    log.debug "node_type    : $node_type"
    log.debug "auto_scale   : $auto_scale"
    log.debug "one_clicks   : $one_clicks"
    log.debug "k8s_version  : $k8s_version"
    log.debug "do_region    : $do_region"
    log.debug "node_pool    : $node_pool"

    set -lx doctl_args $cluster_name
    set -a doctl_args --verbose
    set -a doctl_args '--auto-upgrade=true'
    set -a doctl_args --region
    set -a doctl_args "$do_region"
    set -a doctl_args --version
    set -a doctl_args "$k8s_version"
    set -a doctl_args --maintenance-window
    set -a doctl_args 'sunday=03:00'
    set -a doctl_args --surge-upgrade

    if test (count $one_clicks) -gt 0
        set -a doctl_args --1-clicks
        set -a doctl_args (string join ',' $one_clicks)
    end

    set -a doctl_args --node-pool
    set -a doctl_args "$node_pool"

    log.info "Creating cluster [$cluster_name]"
    echo doctl kubernetes cluster create $doctl_args

end
