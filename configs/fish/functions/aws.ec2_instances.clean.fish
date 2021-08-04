#!/usr/bin/env fish

function aws.ec2_instances.clean -d "Cleanup any instances that were created to test with"

    if not command.is_available -c aws
        __log error '`aws` is not installed'
        return 1
    end

    function ___usage
        set -l help_args -a 'Cleanup any instances that were created to test with'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
        end
    end

    set -l instance_ids (aws \
      ec2 \
      describe-instances --filters \
      "Name=tag:Name,Values=$USER-test-instance" \
      "Name=instance-state-name,Values=running,shut-down" |\
      dasel select --null --plain -r json -m '.Reservations.[*].Instances.[*].InstanceId')

    if not test $status -eq 0
        __log "Unable to get instances from AWS"
        return 1
    end

    if test "$instance_ids" = null
        __log 'No instances to cleanup.'
        return 1
    end

    __log "Found "(count $instance_ids)" instances to delete..."

    for instance_id in $instance_ids
        __log "Deleting $instance_id"

        aws ec2 terminate-instances --instance-ids $instance_id |
            jq -r '.TerminatingInstances[] | "\(.InstanceId) is currently \(.CurrentState.Name)"'
    end
end
