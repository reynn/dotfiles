#!/usr/bin/env fish
# TODO: Update to run multiple containers?
function docker.containers.run -d 'Run a basic container'

    set -x entrypoint ''
    set -x image 'alpine:latest'
    set -x preset ''
    set -x detach false
    set -x interactive false
    set -x volume_paths "$PWD:/app"
    set -x args --rm -w /app
    set -x env_vars
    set -x presets go python rust debian centos manjaro postgres

    function ___usage -d 'Show usage'
        set -l help_args -a "Run a Docker container with the current directory mounted\n\n## Presets\n\n - "(string join '\n - ' $presets)
        set -a help_args -f "|entrypoint|The Entrypoint for the docker container|$entrypoint"
        set -a help_args -f "e|env|Add environment variables to the running container|"
        set -a help_args -f "i|image|The image to use for the container|$image"
        set -a help_args -f "p|preset|Use a preset for launching the container|$preset"
        set -a help_args -f "V|volume_path|Mount volumes to the container|$volume_paths"
        set -a help_args -f "|port|Port specifications|"
        set -a help_args -f "d|detach|Detach from the container so it runs in the background|$detach"
        set -a help_args -f "|interactive|Run the container in interactive mode|$interactive"
        set -a help_args -e " -i rust:$LANGUAGES_RUST_VERSION --interactive"
        set -a help_args -e " -p centos"
        set -a help_args -e " -p postgres"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case entrypoint
                set -x entrypoint "$value"
            case e env
                set -x -a env_vars "$value"
            case i image
                set -x image "$value"
            case p preset
                set preset "$value"
            case V volume_paths
                set -x -a volume_paths "$value"
            case port
                set -x port "$value"
            case d detach
                set detach true
            case interactive
                set interactive true
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

    if test ! -x (command -s docker)
        log.error 'Docker is not installed'
        return 1
    end

    if test -n $preset
        switch $preset
            case go
                set entrypoint /bin/bash
                set interactive true
                set image "golang:$LANGUAGES_GO_VERSION-buster"
            case python
                set entrypoint /bin/bash
                set interactive true
                set image "python:$LANGUAGES_PYTHON_VERSION"
            case rust
                set entrypoint /bin/bash
                set interactive true
                set image "rust:$LANGUAGES_RUST_VERSION"
            case debian
                set entrypoint /bin/bash
                set interactive true
                set image debian
            case manjaro
                set entrypoint /bin/bash
                set interactive true
                set image manjarolinux/build-stable
            case centos
                set entrypoint /bin/bash
                set interactive true
                set image centos
            case postgres
                set detach true
                set -p env_vars "POSTGRES_PASSWORD=postgres" "POSTGRES_USERNAME=postgres"
                set image "postgres:latest"
        end
    end

    for path in $volume_paths
        set -a args -v $path
    end

    if test "$interactive" = true
        set -p args -it
    end

    if test "$detach" = true
        set -p args -d
    end

    if test -n "$entrypoint"
        set -p args "--entrypoint=$entrypoint"
    end

    if test (count $env_vars) -gt 0
        for env in $env_vars
            if test $env = ""
                continue
            end
            log.debug "VAR: `$env`"
            set -a args -e "$env"
        end
    end

    set -a args $image

log.debug "docker run $args"

    echo docker run $args
end
