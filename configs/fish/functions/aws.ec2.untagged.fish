function aws.ec2.untagged -d 'List all untagged EC2 instances'

    function ___usage
        set -l help_args '-a' "List all untagged EC2 instances"
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case h help
                ___usage
                return 0
            case v verbose
                set -x DEBUG 'true'
        end
    end

    if not utils.command.available -c 'aws'
        log.error -m '`aws` is not installed'
        return 1
    end

    aws ec2 \
        describe-instances \
        --output text \
        --query 'Reservations[].Instances[?!not_null(Tags[?Key == "Name"].Value)] | [].InstanceId' | \
        tr '\t' '\n'
end
