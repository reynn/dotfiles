#!/usr/bin/env fish

function log.debug -d "Log a debug message"
    set -x label
    set -x msg
    set -q COLOR_LOG_DEBUG; and set -x color "$COLOR_LOG_DEBUG"; or set -x color green

    function ___usage
        set -l help_args -a "Log a debug message [color: $color]"
        set -a help_args -f 'l|label|An extra label to include at the beginning, in `()`'

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

    # Return 0 because this isn't an error case we just didn't need to output
    set -q DEBUG; or return 0
    test -n "$label"; and set msg "($label) $msg"

    __log --color "$color" --message "$msg" --level debug
end
