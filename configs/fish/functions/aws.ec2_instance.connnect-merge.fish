#!/usr/bin/env fish
# TODO: Based on what this does it would be better as a flag to aws.ec2_instance.connect
function aws.ec2.ssh.to.instance.via.id -d "SSH to an AWS instance via it's ID instead of IP"
    set -l instance_id $argv[1]

    function ___usage
        set -l help_args -a "SSH to an AWS instance via it's ID instead of IP"
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
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

    if test -z $instance_id
        echo "Must provide an instance ID for a machine to connect to"
    end
    set -l instance_data (aws ec2 describe-instances --instance-ids "$instance_id" | jq -r '.Reservations[0].Instances[0]')
    set -l ip (echo "$instance_data" | jq -r '.PrivateIpAddress')
    set -l key_name (echo "$instance_data" | jq -r '.KeyName')
    set -l instance_name (echo "$instance_data" | jq -r '.Tags[] | select(.Key=="Name").Value')

    __log debug -l instance_id "$instance_id"
    __log debug -l ip "$ip"
    __log debug -l key_name "$key_name"
    __log debug -l instance_name "$instance_name"

    __log "Connecting to EC2 instance $instance_name [$ip] using $key_name"
    ssh -i ~/.ssh/$key_name.pem ec2-user@$ip
end
