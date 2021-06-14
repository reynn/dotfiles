#!/usr/bin/env fish

function aws.ec2_instance.create -d "Create an instance in AWS"

    set -x user_email (git config user.email)
    set -x cfn_template "$DFP/infra/aws/standard-instance.cfn.yaml"
    set -x stack_name "$USER-test-stack-"(date +%Y-%m-%d)
    set -x tags "Owner=$user_email"

    function ___usage
        set -l help_args -a "Create an instance in AWS Using a the standard CFN template"

        set -a help_args -f "t|template|Cloudformation template to use|"(basename $cfn_template)
        set -a help_args -f "s|stack-name|Stack name to use|$stack_name"
        set -a help_args -f "T|tag|Bar separated list of tags|["(count tags)"] $tags"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case t template
                set cfn_template "$value"
            case s stack-name
                set stack_name "$value"
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

    log debug "aws cloudformation deploy --stack-name $stack_name--template-file "$cfn_template""
    cat $cfn_template
end
