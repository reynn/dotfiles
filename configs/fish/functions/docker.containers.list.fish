#!/usr/bin/env fish

function docker.containers.list -d "Show a list of containers with minimal information"
    function ___usage
        set -l help_args -a 'Show a list of containers with minimal information'
        set -a help_args -c '1|Command not available'
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

    if not command.is_available -c docker
        log error '`docker` is not installed'
        return 1
    end

    docker container ls -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'
end
