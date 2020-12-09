#!/usr/bin/env fish

function docker.container.clean -d "Clean up containers"
    set -l all 'false'
    function ___usage
        set -l help_args '-a' 'Clean up Docker containers'
        set -l help_args '-f' "a|all|Remove all images|$all"
        set -a help_args '-c' '1|Command not available'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case a all
                set all 'true'
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

    if test "$all" = 'true'
        log.info -m 'Removing all existing containers'
        docker container rm -f (docker container ls -qa)
    else
        log.info -m 'Removing exited and stopped containers'
        docker container rm -f (docker container ls -q)
    end
end
