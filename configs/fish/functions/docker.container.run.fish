#!/usr/bin/env fish

function docker.container.run -d "Run a basic container"
    set -lx entrypoint '/bin/bash'
    set -lx image 'alpine:latest'
    set -lx preset ''
    set -lx detach 'false'
    set -lx interactive 'false'
    set -lx volume_paths
    set -lx env_vars

    function ___usage -d 'Show usage'
        set -l help_args '-a' 'Run a Docker container with the current directory mounted'
        set -a help_args '-f' '|entrypoint|The Entrypoint for the docker container'
        set -a help_args '-f' 'e|env|Add environment variables to the running container'
        set -a help_args '-f' 'i|image|The image to use for the container'
        set -a help_args '-f' 'p|preset|Use a preset for launching the container'
        set -a help_args '-f' 'v|volume_path|Mount volumes to the container'
        set -a help_args '-f' '|port|Port specifications'
        set -a help_args '-f' 'd|detach|Detach from the container so it runs in the background'
        set -a help_args '-f' '|interactive|Run the container in interactive mode'
        set -a help_args '-e' " -i rust:$LANGUAGES_RUST_VERSION --interactive"
        set -a help_args '-e' " -p centos"
        set -a help_args '-e' " -p postgres"

        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case h help
                ___usage
                return 0
            case entrypoint
                set entrypoint $value
            case e env
                set -a env_vars $value
            case i image
                set image $value
            case p preset
                set preset $value
            case v volume_paths
                set -a volume_paths $value
            case port
                set port $value
            case d detach
                set detach 'true'
            case interactive
                set interactive 'true'
        end
    end

    if test -x (command -s docker)
        log.error -m 'Docker is not installed'
        return 1
    end

    set -l args '--rm'

    if test -n $preset
        switch $preset
            case "go"
                set entrypoint "/bin/bash"
                set interactive 'true'
                set image "golang:$LANGUAGES_GO_VERSION-buster"
            case "python"
                set entrypoint "/bin/bash"
                set interactive 'true'
                set image "python:$LANGUAGES_PYTHON_VERSION"
            case "rust"
                set entrypoint "/bin/bash"
                set interactive 'true'
                set image "rust:$LANGUAGES_RUST_VERSION"
            case "debian"
                set entrypoint "/bin/bash"
                set interactive 'true'
                set image "debian"
            case "centos"
                set entrypoint "/bin/bash"
                set interactive 'true'
                set image "centos"
            case "postgres"
                set detach 'true'
                set -p env_vars "POSTGRES_PASSWORD=postgres" "POSTGRES_USERNAME=postgres"
                set image "postgres:latest"
        end
    end

    if test "$interactive" = 'true'
        set -a volume_paths "$PWD:/app"
        set -a args -w '/app'
    end

    for path in $volume_paths
        set -a args -v $path
    end

    if test "$interactive" = "true"
        set -p args '-it'
    end

    if test "$detach" = "true"
        set -p args '-d'
    end

    if test -n "$entrypoint"
        set -p args "--entrypoint=$entrypoint"
    end

    if test (count $env_vars) -gt 0
        for env in $env_vars
            if test $env = ""
                continue
            end
            log.debug -m "VAR: `$env`"
            set -a args '-e' "$env"
        end
    end

    set -a args $image

    log.debug -m "docker run $args"

    docker run $args
end
