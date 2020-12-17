#!/usr/bin/env fish

function docker.container.clean -d "Clean up containers"
    set -lx all 'false'

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

    if not utils.command.available -c 'docker'
        log.error -m '`docker` is not installed'
        return 1
    end

    set -l containers
    if test "$all" = 'true'
        set containers (docker container ls -qa)
    else
        set containers (docker container ls -q)
    end
    if test (count $containers) -gt 0
        log.info -m "Cleaning "(count $containers)" containers"
        docker container rm -f $containers
    else
        log.info -m "There are no containers to remove"
    end
end
