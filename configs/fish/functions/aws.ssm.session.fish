function aws.ssm.session -d 'Connect to an EC2 instance using AWS Session Manager'
    function ___usage
        set -l help_args '-a' "Connect to an EC2 instance using AWS Session Manager"
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

    aws ssm start-session --target $argv
end
