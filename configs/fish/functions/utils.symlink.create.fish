#!/usr/bin/env fish

function utils.symlink.create -d "Create a symlink, overwriting any existing ones"
    set -lx function_name (status current-function)

    function ___usage
        set -a help_args '-f' "s|src|The original file that is being linked"
        set -a help_args '-f' "d|dest|Where the link will be created"
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case h help
                ___usage
                return 0
            case s src
                set src $value
            case d dest
                set dest $value
            case v verbose
                set -lx DEBUG 'true'
        end
    end

    if test -z "$src"
        log.error -m "src must be set"
        return 2
    end
    if test -z "$dest"
        log.error -m "dest must be set"
        return 2
    end
    if test "$src" = "$dest"
        log.error -m "Src and dest cannot be the same"
        return 2
    end

    log.info -m "$function_name Linking $src -> $dest"
    ln -fs $src $dest
end
