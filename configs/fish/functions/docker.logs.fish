#!/usr/bin/env fish

function docker.logs -d 'Show logs for a running container'
    set -l docker_args -f
    set -lx container
    set -lx fzf_preview 'docker log --since 2m {}'

    function ___usage -d 'Show usage'
        set -l help_args -a 'Show logs for a running container'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case c container
                set container $value

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

    if test -z "$container"
        set container (docker container ls --format "{{ .Names }}" | fzf --select-1 --preview "$fzf_preview")
    end

    docker logs $docker_args $container
end
