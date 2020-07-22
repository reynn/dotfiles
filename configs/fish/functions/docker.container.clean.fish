function docker.container.clean -d "Clean up containers"
    set -l all 'false'

    getopts $argv | while read -l key value
        switch $key
            case a all
                set all 'true'
        end
    end

    if test "$all" = "true"
        echo "Removing all existing containers"
    else
        echo "Removing exited and stopped containers"
    end
end
