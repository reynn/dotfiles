#!/usr/bin/env fish

function aws.ec2.cleanup.test.instances -d "Cleanup any instances that were created to test with"
    if test -x (command -s aws)
        log.error -m 'AWS CLI is not installed'
        return 1
    end

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

    for instance_id in $instance_ids
        echo "Deleting $instance_id"

        aws ec2 terminate-instances --instance-ids $instance_id |
        jq -r '.TerminatingInstances[] | "\(.InstanceId) is currently \(.CurrentState.Name)"'
    end
end
