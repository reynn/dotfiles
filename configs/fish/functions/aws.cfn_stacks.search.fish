#!/usr/bin/env fish

function aws.cfn_stacks.search -d 'Get a list of AWS Cloudformation stacks that match the specified pattern'
    if not command.is_available -c aws
        __log error '`aws` is not installed'
        return 1
    end
    set -x matcher

    function ___usage
        set -l help_args -a 'Get a list of AWS Cloudformation stacks that match the specified pattern'

        set -a help_args -f 'm|match|The matcher to use to find Stach names|$matcher'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case m match
                set matcher "$value"
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

    aws cloudformation list-stacks --query "StackSummaries[].StackName" | jq -r "map(match(\".*$matcher.*\"; \"ig\")) | .[].string"
end
