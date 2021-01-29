#!/usr/bin/env fish

function docker.images.clean -d 'Clean up Images'
    set -l all false

    function ___usage
        set -l help_args -a 'Clean up Docker images'
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

    if test -x (command -s docker)
        log.error 'Docker is not installed'
        return 1
    end

    if test "$all" = true
        log.info 'Removing all existing images'
        docker image rm -f (docker image ls -qa)
    else
        log.info 'Removing exited and stopped images'
        docker image rm -f (docker image ls -q)
    end
end
