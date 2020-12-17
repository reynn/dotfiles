#!/usr/bin/env fish

function aws.cfn.find.stacks -d 'Get a list of AWS Cloudformation stacks that match the specified pattern'
    set -lx matcher

    function ___usage
        set -l help_args '-a' 'Get a list of AWS Cloudformation stacks that match the specified pattern'
        set -a help_args '-f' 'm|match|The matcher to use to find Stach names|$matcher'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case m match
                set matcher "$value"
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
    end

    if not utils.command.available -c 'aws'
        log.error -m '`aws` is not installed'
        return 1
    end

    aws cloudformation list-stacks --query "StackSummaries[].StackName" | jq -r "map(match(\".*$matcher.*\"; \"ig\")) | .[].string"
end
