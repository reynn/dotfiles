
function aws_ec2_cleanup_test_instances -d ""
    set -l instance_ids (aws \
    ec2 \
    describe-instances \
    --filters "Name=tag:Name,Values=$USER-test-instance" \
    "Name=instance-state-name,Values=running,shut-down" |
    jq -r '.Reservations[].Instances[].InstanceId')
    if test ! $status -eq 0
        echo "Unable to get instances from AWS"
        return 1
    end

    if test "$instance_ids" = '0'
        print_info 'No instances to cleanup...'
        return 1
    end

    echo "Found "(count $instance_ids)" instances to delete..."
    return 0

    for instance_id in $instance_ids
        echo "Deleting $instance_id"
        aws_ec2_tear_down_instance $instance_id
    end
end
