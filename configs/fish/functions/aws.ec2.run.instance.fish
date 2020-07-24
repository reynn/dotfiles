function aws.ec2.run.instance -d "Create an instance in AWS" --argument-names force_search ami_id ami_owner ami_filter
    set -l force_search 'false'
    set -l ami_id ''
    set -l ami_owner '966799970081'
    set -l instance_type 't3.large'
    set -l ami_filter 'golden-ami-rhel-7.8.*-cis-2-fips'
    set -l i_count '1'
    set -l name "$USER-test-instance"

    getopts $argv | while read -l key value
        switch $key
            case a ami_id
                set ami_id $value
            case f ami_filter
                set ami_filter $value
            case i instance_type
                set instance_type $value
            case s force_search
                set force_search 'true'
            case c i_count
                set i_count $value
            case n name
                set name $value
        end
    end

    if test "$force_search" = 'true' || test -z $ami_id
        echo "Finding latest image based on [filter: $ami_filter] and [owner: $ami_owner]"
        set ami_id (
          aws \
            ec2 \
            describe-images \
            --filters "Name=name,Values=$ami_filter*" \
            --owners "$ami_owner" |\
              jq -r '.Images[].ImageId' |\
              fzf --select-1 --prompt 'AMI> ' --height 40% --preview 'aws ec2 describe-images --image-ids {} | jq ".Images[] | {Name,State,PlatformDetails,Description}"'
        )
        if test ! $status -eq 0
            echo "Unable to find a valid AMI to use"
            return
        end
        echo "Latest AMI is $ami_id..."
    end

    set -l instance_json (aws.utils.json.run.instances --ami_id $ami_id --name $name --launch_count $i_count --instance_type $instance_type)
    set -l instances (aws ec2 run-instances --output json --cli-input-json $instance_json)
    log.debug -l 'run.instance.result' -m $instances

    log.info -l "Instance ID(s)" -m (echo $instances | jq -r '.Instances[].InstanceId')
    log.info -l "IP Address(es)" -m (echo $instances | jq -r '.Instances[].PrivateIpAddress')
end
