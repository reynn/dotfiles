#!/usr/bin/env fish

function log.warn -d "Log a warning message"
    set -x label
    set -x msg
    set -q COLOR_LOG_WARN; and set -x color "$COLOR_LOG_WARN"; or set -x color yellow

    function ___usage
        set -x help_args -a "Log a warning message [color: $color]"

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

    __log --color "$color" --message "$msg" --level warn
end
