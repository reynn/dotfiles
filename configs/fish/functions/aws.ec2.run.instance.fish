#!/usr/bin/env fish

function aws.ec2.run.instance -d "Create an instance in AWS"

    set -lx function_name (status current-function)
    set -lx force_search 'false'
    set -lx ami_id ''
    set -lx ami_owner '966799970081'
    set -lx instance_type 't3.large'
    set -lx ami_filter 'golden-ami-rhel-7.9.*'
    set -lx i_count '1'
    set -lx name "$USER-test-instance"

    function ___usage
        set -l help_args '-a' "Create an instance in AWS"
        set -a help_args '-f' "a|ami-id|Ami to use, if not specified will provide a list to choose from|$ami_id"
        set -a help_args '-f' "f|ami-filter|Used to filter the search results if the `ami_id` flag is empty|$ami_filter"
        set -a help_args '-f' "i|instance-type|The size of the instance|$instance_type"
        set -a help_args '-f' "s|force-search|Will search for AMIs even if one is provided|false"
        set -a help_args '-f' "c|i-count|Number of instances to launch|$i_count"
        set -a help_args '-f' "n|name|Name of the instance to launch, number is appended for multiple instances|$name"
        set -a help_args '-e' ""
        set -a help_args '-e' " --ami_id "
        set -a help_args '-e' " -f 'ubuntu-*' -n 'ami-tester'"

        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case h help
                ___usage
                return 0
            case v verbose
                set -x DEBUG 'true'
            case a "ami-id"
                set ami_id $value
            case f "ami-filter"
                set ami_filter $value
            case i "instance-type"
                set instance_type $value
            case s "force-search"
                set force_search 'true'
            case c "i-count"
                set i_count $value
            case n name
                set name $value
        end
    end

    if not utils.command.available -c 'aws'
        log.error -m '`aws` is not installed'
        return 1
    end

    log.debug -m "force_search  : $force_search"
    log.debug -m "ami_id        : $ami_id"
    log.debug -m "ami_owner     : $ami_owner"
    log.debug -m "instance_type : $instance_type"
    log.debug -m "ami_filter    : $ami_filter"
    log.debug -m "i_count       : $i_count"
    log.debug -m "name          : $name"

    if test -x (command -s aws)
        log.error -m 'AWS CLI is not installed'
        return 1
    end

    if test "$force_search" = 'true' || test -z $ami_id
        echo "Finding latest image based on [filter: $ami_filter] and [owner: $ami_owner]"
        set ami_id (
          aws \
            ec2 \
            describe-images \
            --filters "Name=name,Values=$ami_filter*" \
            --owners "$ami_owner" |
              jq -r '.Images[].ImageId' |
              fzf --select-1 --prompt 'Image> ' --height 40% --preview 'aws ec2 describe-images --image-ids {} | jq ".Images[] | {Name,State,PlatformDetails,Description}"'
        )
        if test ! $status -eq 0
            log.error -m "Unable to find a valid AMI to use"
            return 1
        end
        log.info -m "Latest AMI is $ami_id"
    end

    set -l instance_json (aws.utils.json.run.instances --ami_id $ami_id --name $name --launch_count $i_count --instance_type $instance_type)
    if test $status -gt 0
        log.error -m "Failed to create CLI JSON, please review errors above."
        return 2
    end
    set -l instances (aws ec2 run-instances --output json --cli-input-json $instance_json)
    log.debug -l 'run.instance.result' -m $instances

    log.info -l "Instance ID(s)" -m (echo $instances | jq -r '.Instances[].InstanceId' | string join ',')
    log.info -l "IP Address(es)" -m (echo $instances | jq -r '.Instances[].PrivateIpAddress' | string join ',')
end
