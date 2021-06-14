#!/usr/bin/env fish
# TODO: Based on what this does it would be better as a flag to aws.ec2_instance.connect
function aws.ssm.session -d 'Connect to an EC2 instance using AWS Session Manager'
    function ___usage
        set -l help_args -a "Connect to an EC2 instance using AWS Session Manager"

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
        log error '`aws` is not installed'
        return 1
    end

    aws ssm start-session --target $argv
end
