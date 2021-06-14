#!/usr/bin/env fish

function docker.containers.clean -d "Clean up containers"
    set -x all false

    function ___usage
        set -l help_args -a 'Clean up Docker containers'
        set -l help_args -f "a|all|Remove all images|$all"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case a all
                set all true
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

    set -l containers
    if test "$all" = true
        set containers (docker container ls -qa)
    else
        set containers (docker container ls -q)
    end
    if test (count $containers) -gt 0
        log "Cleaning "(count $containers)" containers"
        docker container rm -f $containers
    else
        log "There are no containers to remove"
    end
end
