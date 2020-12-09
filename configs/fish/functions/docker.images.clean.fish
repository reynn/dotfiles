function docker.images.clean -d 'Clean up Images'
    set -l all 'false'

    function ___usage
        set -l help_args '-a' 'Clean up Docker images'
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
        log.info -m 'Removing all existing images'
        docker image rm -f (docker image ls -qa)
    else
        log.info -m 'Removing exited and stopped images'
        docker image rm -f (docker image ls -q)
    end
end
