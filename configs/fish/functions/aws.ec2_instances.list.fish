#!/usr/bin/env fish
# TODO: Update to list more than just untagged in a better way
function aws.ec2.untagged -d 'List all untagged EC2 instances'

    function ___usage
        set -l help_args -a "List all untagged EC2 instances"

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

    if not command.is_available -c aws
        __log error '`aws` is not installed'
        return 1
    end

    aws ec2 \
        describe-instances \
        --output text \
        --query 'Reservations[].Instances[?!not_null(Tags[?Key == "Name"].Value)] | [].InstanceId' | tr '\t' '\n'
end
