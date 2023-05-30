#!/usr/bin/env fish

function aws.ec2_instance.connect -d "Interactively connect to a created instance"
    if not command.is_available -c aws
        __log error '`aws` is not installed'
        return 1
    end
    set -x tmp_file (mktemp)
    set -x filters "Name=tag:Owner,Values=$EMAIL" "Name=instance-state-name,Values=running"
    set -x connect_method ssh
    set -x aws_profile default
    set -x filters
    set -x instance_id
    set -x ssh_user_name ec2-user

    function ___usage
        set -l help_args -a "Interactively connect to a created instance"

        set -a help_args -f "I|instance-id|ID of the instance to connect to|[]"
        set -a help_args -f "f|filter|Set of filters to narrow down list of instances|$filters"
        set -a help_args -f "F|no-filters|Removes all filters (Will grab all running instances)|false"
        set -a help_args -f "|json|Uses the provided file as a JSON dict with keys being a friendly name and values being instance IDs|"
        set -a help_args -f "c|connect-method|Method use to connect to the instance (ssh or ssm)|ssh"
        set -a help_args -f "u|username|The name of the SSH user to connect to|$ssh_user_name"
        set -a help_args -f "p|profile|AWS Profile used for auth|$aws_profile"

        __dotfiles_help $help_args
    end

    function ___connect_via_ssh
        set -l instance $argv[1]
        __log "Connecting to $instance via SSH (AWS Profile: $aws_profile)"
        set -l instance_data (aws --profile "$aws_profile" \
          ec2 describe-instances --instance-ids "$instance" |\
          dasel -p json -m '.Reservations.all().Instances.all()')

        if contains error $instance
            __log error "Failed to get instance data: $instance_data"
            return 1
        end

        set -l ip (echo "$instance_data" | dasel -w plain -r json '.PrivateIpAddress')
        set -l key_name (echo "$instance_data" | dasel -w plain -r json '.KeyName')
        set -l instance_name (echo "$instance_data" | dasel -w plain -r json '.Tags.filter(equal(Key,Name)).Value')

        __log debug "instance       : $instance"
        __log debug "ip             : $ip"
        __log debug "key_name       : $key_name"
        __log debug "instance_name  : $instance_name"

        __log "Connecting to EC2 instance $instance_name [$ip] using $key_name"
        ssh -i ~/.ssh/$key_name.pem "$ssh_user_name@$ip"
    end

    function ___connect_via_ssm
        set -l instance $argv[1]
        __log "Connecting to $instance via AWS SSM"
        aws --profile $aws_profile ssm start-session --target $instance
    end

    getopts $argv | while read -l key value
        switch $key
            case I instance-id
                set -x instance_id $value
            case f filter
                set -a filters "$value"
            case no-filters
                set filters "Name=instance-state-name,Values=running"
            case json
                set json_list $value
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

    # use the configured env profile if set
    set -q AWS_PROFILE; and set aws_profile $AWS_PROFILE

    __log debug "Filters        : $filters"
    __log debug "Tmp_File       : $tmp_file"
    __log debug "ConnectMethod  : $connect_method"
    __log debug "Profile        : $aws_profile"

    if test -z "$instance_id"
        if test -n $json_list
            set -l selection (dasel -w plain -f $json_list 'all().key()' | fzf --height 40%)
            set instance_id (dasel -w plain -f $json_list ".$selection")
        else
            if test -z "$filters"
                __log debug "Getting instances without filters"
                aws --profile "$aws_profile" ec2 describe-instances >$tmp_file
            else
                __log debug "Getting instances with filters"
                aws --profile "$aws_profile" ec2 describe-instances --filters "$filters" >$tmp_file
            end
            set instance_id (dasel -f $tmp_file -r json -w plain '.(?:-=InstanceId)' |
              fzf --select-1 --prompt 'instance-id> ' --height 40% --select-1 \
              --preview "dasel select -f $tmp_file -p json -m '.Reservations.[].Instances.(InstanceId={})'")
        end
    end
    __log debug "instance.id : $instance_id"
    # rm -f $tmp_file
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
