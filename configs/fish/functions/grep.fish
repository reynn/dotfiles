#!/usr/bin/env fish

function grep -d "grep wrapper to use RipGrep if available or builtin when not"
    set -l ripgrep_command (command -s rg)

    if test -n "$ripgrep_command"
        log.debug -m "Using RipGrep with args $argv"
        rg $argv
    else
        # use the true command instaed of an alias
        set -l grep_command (command -s grep)
        log.debug -m "Using [$grep_command] with args $argv"
        $grep_command $argv
    end
end
