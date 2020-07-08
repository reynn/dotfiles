set EC2_INSTANCE_PREVIEW_COMMAND 'aws ec2 describe-instances --instance-ids {} | jq ".Reservations[].Instances[] | {ami: .ImageId, dns: .PrivateDnsName, az: .Placement.AvailabilityZone, tags: .Tags}"'

function aws_ec2_connect_to_test_instance
    set -l instance_id (aws \
    ec2 \
    describe-instances \
    --filters "Name=tag:Name,Values=$USER-test-instance" \
    "Name=instance-state-name,Values=running" |
    jq -r '.Reservations[].Instances[].InstanceId' |
    fzf --select-1 --prompt 'instance> ' --height 40% --preview $EC2_INSTANCE_PREVIEW_COMMAND)

    if ! test -z "$instance_id"
        aws_ec2_ssh_to_instance_via_id $instance_id
    end
end
