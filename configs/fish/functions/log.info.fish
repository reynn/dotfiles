#!/usr/bin/env fish

function log.info -d "Log an info message"
    set -x label
    set -x msg
    set -q COLOR_LOG_INFO; and set -x color "$COLOR_LOG_INFO"; or set -x color blue

    function ___usage
        set -l help_args -a "Log an info message [color: $color]"
        set -a help_args -f 'l|label|An extra label to include at the beginning in between `()`'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case _
                set msg "$value"
            case l label
                set label "$value"
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
    test -n "$label"; and set msg "($label) $msg"

    __log --color "$color" --message "$msg" --level info
end
