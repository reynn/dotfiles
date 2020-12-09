#!/usr/bin/env fish

function docker.container.list -d "Show a list of containers with minimal information"
    function ___usage
        set -l help_args '-a' 'Show a list of containers with minimal information'
        set -a help_args '-c' '1|Command not available'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
    end

    if test -x (command -s docker)
        log.error -m 'Docker is not installed'
        return 1
    end

    docker container ls -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'
end
