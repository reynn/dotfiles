
function aws_ec2_create_test_instance -d "Create a test instance in AWS" -a force_search ami_id ami_owner ami_filter
    set -l force_search 'false'
    set -l ami_id ''
    set -l ami_owner '966799970081'
    set -l ami_filter 'golden-image-cis-centos-7.8'

    getopts $argv | while read -l key value
        switch $key
            case a ami_id
                set ami_id $value
            case f ami_filter
                set ami_filter $value
            case s force_search
                set force_search $value
        end
    end

    if test "$force_search" = 'true' || test -z $ami_id
        echo "Finding latest image based on [filter: $ami_filter] and [owner: $ami_owner]"
        set ami_id (
      aws \
        ec2 \
        describe-images \
        --filters "Name=name,Values=$ami_filter*" \
        --owners "$ami_owner" \
        --query 'Images[-1].ImageId' \
        --output text
    )
        if test ! $status -eq 0
            echo "Unable to find a valid AMI to use"
            return
        end
        echo "Latest AMI is $ami_id..."
    end

    set -l instance_json (aws_ec2_create_run_instances_json --amiid $ami_id)

    # echo "DEBUG: force_search: $force_search"
    # echo "DEBUG: ami_id: $ami_id"
    # echo "DEBUG: ami_owner: $ami_owner"
    # echo "DEBUG: ami_filter: $ami_filter"

    set -l instance (aws ec2 run-instances --output json --cli-input-json $instance_json)

    echo "Instance ID: "(echo $instance | jq -r '.Instances[0].InstanceId')
    echo "IP Address: "(echo $instance | jq -r '.Instances[0].PrivateIpAddress')
end
