#!/usr/bin/env fish

function aws.ec2.connect.to.instance -d "Interactively connect to a created instance"
    set -l tmp_file (mktemp)
    set -l filters "Name=tag:Owner,Values=$EMAIL" "Name=instance-state-name,Values=running"

    aws ec2 describe-instances --filters $filters >$tmp_file

    set -l instance_id (jq -r '.Reservations[].Instances[].InstanceId' $tmp_file |
      fzf --select-1 --prompt 'instance> ' --height 70% --preview "jq -S '.Reservations[].Instances[] | select(.InstanceId==\"{}\") | {InstanceId,ImageId,InstanceType,PrivateIpAddress,Tags}' $tmp_file")

    log.debug -m $instance_id -l "instance.id"
    rm -f $tmp_file
    if ! test -z "$instance_id"
        aws.ec2.ssh.to.instance.via.id $instance_id
    end
end
