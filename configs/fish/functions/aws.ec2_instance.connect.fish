#!/usr/bin/env fish

function aws.ec2_instance.connect -d "Interactively connect to a created instance"
    set -l tmp_file (mktemp)
    set filters "Name=tag:Owner,Values=$EMAIL" "Name=instance-state-name,Values=running"
    set connect_method ssh
    set aws_profile default
    set filters

    function ___usage
        set -l help_args -a "Interactively connect to a created instance"
        set -a help_args -f "f|filter|Set of filters to narrow down list of instances|$filters"
        set -a help_args -f "F|no-filters|Removes all filters (Will grab all running instances)|false"
        set -a help_args -f "c|connect-method|Method use to connect to the instance (ssh or ssm)|ssh"
        set -a help_args -f "p|profile|AWS Profile used for auth|$aws_profile"
        set -a help_args -f e

        __dotfiles_help $help_args
    end

    function ___connect_via_ssh
        set -l instance $argv[1]
        __log "Connecting to $instance via SSH"
    end

    function ___connect_via_ssm
        set -l instance $argv[1]
        __log "Connecting to $instance via AWS SSM"
        aws --profile $aws_profile ssm start-session --target $instance
    end

    getopts $argv | while read -l key value
        switch $key
            case _
                set -x instance_id $value
            case f filter
                set -a filters "$value"
            case no-filters
                set filters "Name=instance-state-name,Values=running"
            case c connect-method
                set connect_method $value
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
        __log error 'AWS CLI is not installed'
        return 1
    end

    __log debug "Filters   : $filters"
    __log debug "Tmp_File  : $tmp_file"
    __log debug "Connect   : $connect_method"
    __log debug "Profile   : $aws_profile"

    if test -z "$instance_id"
        aws --profile $aws_profile ec2 describe-instances --filters $filters >$tmp_file
        set instance_id (jq -r '.Reservations[].Instances[].InstanceId' $tmp_file |
          fzf --select-1 --prompt 'instance> ' --height 50% \
          --preview "jq -S '.Reservations[].Instances[] | select(.InstanceId==\"{}\") | {InstanceId,ImageId,InstanceType,PrivateIpAddress,Tags}' $tmp_file")
    end
    __log debug $instance_id -l "instance.id"
    rm -f $tmp_file
    if ! test -z "$instance_id"
        switch $connect_method
            case ssh
                ___connect_via_ssh $instance_id
            case ssm
                ___connect_via_ssm $instance_id
            case *
                __log error "Invalid connect method: $connect_method"
        end
    end
end
