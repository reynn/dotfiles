function aws_ec2_tear_down_instance -d ""
    set -l instance_id "$argv[1]"
    if test -z "$instance_id"
        echo "Please provide an AWS EC2 instance ID"
        return 1
    end

    aws ec2 terminate-instances --instance-ids $instance_id |
    jq -r '.TerminatingInstances[] | "\(.InstanceId) is currently \(.CurrentState.Name)"'
end
