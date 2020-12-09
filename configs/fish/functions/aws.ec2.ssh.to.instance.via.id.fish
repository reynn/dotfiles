#!/usr/bin/env fish

function aws.ec2.ssh.to.instance.via.id -d "SSH to an AWS instance via it's ID instead of IP"
    set -l instance_id $argv[1]

    if test -x (command -s aws)
        log.error -m 'AWS CLI is not installed'
        return 1
    end

    if test -z $instance_id
        echo "Must provide an instance ID for a machine to connect to"
    end
    set -l instance_data (aws ec2 describe-instances --instance-ids "$instance_id" | jq -r '.Reservations[0].Instances[0]')
    set -l ip (echo "$instance_data" | jq -r '.PrivateIpAddress')
    set -l key_name (echo "$instance_data" | jq -r '.KeyName')
    set -l instance_name (echo "$instance_data" | jq -r '.Tags[] | select(.Key=="Name").Value')

    log.debug -l "instance_id" -m "$instance_id"
    log.debug -l "ip" -m "$ip"
    log.debug -l "key_name" -m "$key_name"
    log.debug -l "instance_name" -m "$instance_name"

    log.info -m "Connecting to EC2 instance $instance_name [$ip] using $key_name"
    ssh -i ~/.ssh/$key_name.pem ec2-user@$ip
end
