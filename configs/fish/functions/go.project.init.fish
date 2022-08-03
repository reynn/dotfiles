#!/usr/bin/env fish

function go.project.init -d "Initialize a new Go project including mod file"
    set -x project_name (echo $PWD | string split -m 4 '/' | tail -n1)

    function ___usage
        set -l help_args -a "Initialize a new Go project including mod file"
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case n project-name
                set project_name "$value"

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

    go mod init "$project_name"
    printf "package main\n\nfunc main() {\n\n}" >> main.go
    mkdir -p {internal,cmds}
end
