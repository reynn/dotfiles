#!/usr/bin/env fish

function grep -d "grep wrapper to use RipGrep if available or builtin when not"
    set -l ripgrep_command (command -s rg)

    function ___usage
        set -l help_args '-a' 'grep wrapper to use RipGrep if available or builtin when not'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case h help
                ___usage
                return 0
            case v verbose
                set -x DEBUG 'true'
        end
    end

    if test -n "$ripgrep_command"
        log.debug -m "Using RipGrep with args $argv"
        rg $argv | rg -v "$argv"
    else
        # use the true command instaed of an alias
        set -l grep_command (command -s grep)
        log.debug -m "Using [$grep_command] with args $argv"
        $grep_command $argv | $grep_command -v "$grep_command"
    end
end
