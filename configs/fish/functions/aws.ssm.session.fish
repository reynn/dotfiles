function aws.ssm.session

    if test -x (command -s aws)
        log.error -m 'AWS CLI is not installed'
        return 1
    end

    aws ssm start-session --target $argv
end
