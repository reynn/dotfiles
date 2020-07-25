function docker.container.connect -d "Select a container to attach too"
    set -l container ""

    getopts $argv | while read -l key value
        switch $key
            case c container
                set container $value
        end
    end

    if test -z $container
        set container (docker container ls --all --format 'table {{.Names}}' |\
          fzf --select-1 --header-lines 1 --height 40% --preview 'docker inspect {}')
    end

    echo "Connecting to container: $container"
    docker container
end
