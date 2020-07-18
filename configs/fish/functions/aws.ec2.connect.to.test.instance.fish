function aws.ec2.connect.to.test.instance -d "Interactively connect to a created test instance"
    set -l EC2_INSTANCE_PREVIEW_COMMAND 'aws ec2 describe-instances --instance-ids {} | jq ".Reservations[].Instances[] | {ami: .ImageId, dns: .PrivateDnsName, az: .Placement.AvailabilityZone, tags: .Tags}"'
    set -l instance_id (aws \
    ec2 \
    describe-instances \
    --filters "Name=tag:Name,Values=$USER-test-instance" \
    "Name=instance-state-name,Values=running" |
    jq -r '.Reservations[].Instances[].InstanceId' |
    fzf --select-1 --prompt 'instance> ' --height 40% --preview $EC2_INSTANCE_PREVIEW_COMMAND)

    if ! test -z "$instance_id"
        aws.ec2.ssh.to.instance.via.id $instance_id
    end
end
