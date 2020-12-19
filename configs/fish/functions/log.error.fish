#!/usr/bin/env fish

function log.error -d "Log a error message"
    set -x label
    set -x msg
    set -q COLOR_LOG_ERROR; and set -x color "$COLOR_LOG_ERROR"; or set -x color "$fish_color_error"

    function ___usage
        set -l help_args '-a' "Log an error message [color: $color]"
        set -a help_args '-f' 'l|label|An extra label to include at the beginning, in `()`'

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
                set -x QUIET 'true'
            case v verbose
                set -x DEBUG 'true'
        end
    end
    test -n "$label"; and set msg "($label) $msg"

    __log --color "$color" --message "$msg" --level error
end
