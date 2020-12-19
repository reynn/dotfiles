#!/usr/bin/env fish

function aws.ec2_instance.connect -d "Interactively connect to a created instance"
    set -l tmp_file (mktemp)
    set -x filters "Name=tag:Owner,Values=$EMAIL" "Name=instance-state-name,Values=running"

    function ___usage
        set -l help_args '-a' "Interactively connect to a created instance"
        set -a help_args '-f' "f|filter|Set of filters to narrow down list of instances|$filters"
        set -a help_args '-f' "|no-filters|Removes all filters (Will grab all running instances)|false"
        set -a help_args '-u' "Used to connect to an instance created by another function or the Web UI"
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case f filter
                set -x -a filters "$value"
            case "no-filters"
                set filters "Name=instance-state-name,Values=running"
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET 'true'
            case v verbose
                set -x DEBUG 'true'
        end
    end

    if not command.is_available -c 'aws'
        log.error '`aws` is not installed'
        return 1
    end

    log.debug "Filters   : $filters"
    log.debug "Tmp_File  : $tmp_file"

    aws ec2 describe-instances --filters $filters >$tmp_file

    set -l instance_id (jq -r '.Reservations[].Instances[].InstanceId' $tmp_file |
      fzf --select-1 --prompt 'instance> ' --height 50% \
        --preview "jq -S '.Reservations[].Instances[] | select(.InstanceId==\"{}\") | {InstanceId,ImageId,InstanceType,PrivateIpAddress,Tags}' $tmp_file")

    log.debug $instance_id -l "instance.id"
    rm -f $tmp_file
    if ! test -z "$instance_id"
        aws.ec2.ssh.to.instance.via.id $instance_id
    end
end
