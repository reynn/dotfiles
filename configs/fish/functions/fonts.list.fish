#!/usr/bin/env fish

## #######################################################################
## Examples
## #######################################################################
## `fonts.list | fzf` -> list all fonts piped to fzf for easier searching
## #######################################################################

function fonts.list -d 'List all installed font families, sorted by name'
    function ___usage
        set -l help_args '-a' 'List all installed font families, sorted by name'
        set -a help_args '-c' '1|Command not available'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
    end

    if not utils.command.available -c 'fc-list'
        log.error -m 'Command `fc-list` is not available'
        return 1
    end

    fc-list --format="%{family[0]}\n" | sort -u
end
