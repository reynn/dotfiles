#!/usr/bin/env fish

function docker.container.connect -d "Select a container to attach too"
    set -l container

    function ___usage
        set -l help_args -a 'Select a container to attach to'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case c container
                set -x container "$value"
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
        __log error '`docker` is not installed'
        return 1
    end

    if test -z $container
        set container (docker container ls --all --format 'table {{.Names}}' |\
          fzf --select-1 --header-lines 1 --height 40% --preview 'docker inspect {}')
    end

    echo "Connecting to container: $container"
    docker container
end
