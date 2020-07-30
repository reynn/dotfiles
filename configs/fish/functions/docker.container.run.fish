#!/usr/bin/env fish

function docker.container.run -d "Run a basic container"
    set -l entrypoint "/bin/bash"
    set -l image "alpine:latest"
    set -l language ""

    getopts $argv | while read -l key value
        switch $key
            case e entrypoint
                set entrypoint $value
            case i image
                set image $value
            case l language
                set language $value
        end
    end

    if test -n $language
        switch $language
            case "go"
                set entrypoint "/bin/bash"
                set image "golang:$LANGUAGES_GO_VERSION-buster"
            case "python"
                set entrypoint "/bin/bash"
                set image "python:$LANGUAGES_PYTHON_VERSION"
            case "rust"
                set entrypoint "/bin/bash"
                set image "rust:$LANGUAGES_RUST_VERSION"
        end
    end

    docker run --rm -it -v $PWD:/app -w /app --entrypoint=$entrypoint $image
end
