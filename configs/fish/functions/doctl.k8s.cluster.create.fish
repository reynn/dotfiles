function doctl.k8s.cluster.create -d 'Create a Kubernetes cluster in DigitalOcean'
    set -lx cluster_name (hostname -s | string lower)
    set -lx min_size '1'
    set -lx max_size '5'
    set -lx node_type 's-2vcpu-4gb'
    set -lx auto_scale 'true'
    set -lx one_clicks 'argocd' 'loki' 'linkerd2'
    set -lx k8s_version 'latest'
    set -lx do_region 'sfo3'

    function ___usage
        set -l help_args '-a' "Create a Kubernetes cluster in DigitalOcean"
        set -a help_args '-f' "n|name|Name of the cluster|$cluster_name"
        set -a help_args '-f' "|min-size|When auto-scaling the minimum number of nodes in the cluster|$min_size"
        set -a help_args '-f' "|max-size|When auto-scaling the maximum number of nodes in the cluster|$max_size"
        set -a help_args '-f' "t|node-type|Size of the nodes in the cluster|$node_type"
        set -a help_args '-f' "A|auto-scale|Enable auto scaling of the cluster|$auto_scale"
        set -a help_args '-f' "O|one-clicks|Enable one-click installs of these apps to the cluster|$one_clicks"
        set -a help_args '-f' "V|k8s-version|Version of Kubernetes cluster|$k8s_version"
        set -a help_args '-f' "R|do-region|The region of DigitalOcean to create the cluster in|$do_region"
        set -a help_args '-e' ' -n nonprod-cluster-formidable --min-size 3 --max-size 10'
        set -a help_args '-e' ' -n prod-cluster-ayanami --min-size 30 --max-size 100 --node-type m3-4vcpu-32gb'
        set -a help_args '-c' '1|`doctl` is missing from PATH'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case n name
                set cluster_name $value
            case 'min-size'
                set min_size $value
            case 'max-size'
                set max_size $value
            case A 'auto-scale'
                set auto_scale 'true'
            case O 'one-clicks'
                set -a one_clicks $value
            case R 'do-region'
                set do_region $value
            case t 'node-type'
                set node_type $value
            case v verbose
                set -x DEBUG 'true'
            case V 'k8s-version'
                set k8s_version $value
            case h help
                ___usage
                return 0
        end
    end

    if test ! -x (command -s doctl)
        log.error -m "`doctl` is not available on this system"
        return 1
    end

    if test -z "$cluster_name"
        log.error -l 'cluster_name' -m 'Cluster name is required'
        return 2
    end

    if test "$min_size" = "$max_size"
        set auto_scale 'false'
    end

    log.debug -l 'cluster_name' -m "$cluster_name"
    log.debug -l 'min_size' -m "$min_size"
    log.debug -l 'max_size' -m "$max_size"
    log.debug -l 'node_type' -m "$node_type"
    log.debug -l 'auto_scale' -m "$auto_scale"
    log.debug -l 'one_clicks' -m "$one_clicks"
    log.debug -l 'k8s_version' -m "$k8s_version"
    log.debug -l 'do_region' -m "$do_region"

    log.info -m "Creating cluster [$cluster_name]"
    # doctl kubernetes cluster create \
    #     $cluster_name \
    #     --auto-upgrade \
    #     --region $do_region \
    #     --version $k8s_version \
    #     --surge-upgrade \
    #     --maintenance-window sunday=03:00 \
    #     --1-clicks (string join ',' $one_clicks) \
    #     --node-pool "name=$cluster_name-pool;auto-scale=$auto_scale;size=$node_type;count=$min_size;min-nodes=$min_size;max-nodes=$max_size;"

end
