function docker.images.clean -d "Clean up Images"
    set -l all 'false'

    getopts $argv | while read -l key value
        switch $key
            case a all
                set all 'true'
        end
    end

    if test "$all" = 'true'
        log.info -m 'Removing all existing images'
        docker image rm -f (docker image ls -qa)
    else
        log.info -m 'Removing exited and stopped images'
        docker image rm -f (docker image ls -q)
    end
end
