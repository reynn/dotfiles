#!/usr/bin/env fish

function tokens.list -d 'List all environment variables that have token in the name'

    function ___usage
        set -l help_args '-a' 'List all environment variables that have token in the name'
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET 'true'
            case v verbose
                set -x DEBUG 'true'
        end
    end
    env | sort -u | grep -i token
end
