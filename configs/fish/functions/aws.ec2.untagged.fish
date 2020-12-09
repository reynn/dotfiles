function aws.ec2.untagged

    if test -x (command -s aws)
        log.error -m 'AWS CLI is not installed'
        return 1
    end

    aws ec2 \
        describe-instances \
        --output text \
        --query 'Reservations[].Instances[?!not_null(Tags[?Key == "Name"].Value)] | [].InstanceId' | \
        tr '\t' '\n'
end
