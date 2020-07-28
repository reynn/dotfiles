function docker.container.clean -d "Clean up containers"
    set -l all 'false'

    getopts $argv | while read -l key value
        switch $key
            case a all
                set all 'true'
        end
    end

    if test "$all" = 'true'
        log.info -m 'Removing all existing containers'
        docker container rm -f (docker container ls -qa)
    else
        log.info -m 'Removing exited and stopped containers'
        docker container rm -f (docker container ls -q)
    end
end
