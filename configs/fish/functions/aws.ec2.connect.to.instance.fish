#!/usr/bin/env fish

function aws.ec2.connect.to.instance -d "Interactively connect to a created instance"
    set -l tmp_file (mktemp)
    set -lx filters "Name=tag:Owner,Values=$EMAIL" "Name=instance-state-name,Values=running"

    function ___usage
        set -l help_args '-a' "Interactively connect to a created instance"
        set -a help_args '-f' "f|filter|Set of filters to narrow down list of instances|$filters"
        set -a help_args '-f' "|no-filters|Removes all filters (Will grab all running instances)|false"
        set -a help_args '-u' "Used to connect to an instance created by another function or the Web UI"
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case h help
                ___usage
                return 0
            case f filter
                set -a filters $value
            case "no-filters"
                set filters "Name=instance-state-name,Values=running"
        end
    end

    log.debug -m "Filters: $filters"
    log.debug -m "Tmp_File: $tmp_file"
    if test -x (command -s aws)
        log.error -m 'AWS CLI is not installed'
        return 1
    end

    aws ec2 describe-instances --filters $filters >$tmp_file

    set -l instance_id (jq -r '.Reservations[].Instances[].InstanceId' $tmp_file |
      fzf --select-1 --prompt 'instance> ' --height 50% \
        --preview "jq -S '.Reservations[].Instances[] | select(.InstanceId==\"{}\") | {InstanceId,ImageId,InstanceType,PrivateIpAddress,Tags}' $tmp_file")

    log.debug -m $instance_id -l "instance.id"
    rm -f $tmp_file
    if ! test -z "$instance_id"
        aws.ec2.ssh.to.instance.via.id $instance_id
    end
end
