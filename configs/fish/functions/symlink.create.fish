#!/usr/bin/env fish

function symlink.create -d "Create a symlink, overwriting any existing ones"
    function ___usage
        set -a help_args -f "s|src|The original file that is being linked"
        set -a help_args -f "d|dest|Where the link will be created"
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case s src
                set -x src "$value"
            case d dest
                set -x dest "$value"
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

    if test -z "$src"
        __log error "src must be set"
        return 2
    end
    if test -z "$dest"
        __log error "dest must be set"
        return 2
    end
    if test "$src" = "$dest"
        __log error "Src and dest cannot be the same"
        return 2
    end

    __log "Linking $src -> $dest"
    ln -fs $src $dest
end
