#!/usr/bin/env fish

function utils.command.available -d 'Determines if a command is available to execute'
    set -lx commands

    function ___usage -d 'Show usage'
        set -l help_args '-a' "Determines if a command is available to execute"

        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case _
                while read -l cmd
                    log.info -m "Adding $cmd"
                end
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
    end
end
