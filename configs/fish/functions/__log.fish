#!/usr/bin/env fish

function __log -d "Log a message"
    if test "$QUIET" = true
        return 0
    end
    set -lx log_levels debug info warn error
    set -lx level info
    set -lx color
    set -lx label
    set -lx msg

    function ___usage
        set -l help_args -a "Log a message"

        set -a help_args -f 'l|label|An extra label to include at the beginning, in `()`'

        __dotfiles_help $help_args
    end

    function ___log
        set -l level
        set -l msg
        set -l color normal
        set -l level_length 6

        getopts $argv | while read -l key value
            switch $key
                case c color
                    set color "$value"
                case l level
                    set level "$value"
                case L length
                    set level_length "$value"
                case m message
                    set msg "$value"
                case v verbose
                    set -x DEBUG true
            end
        end

        # Return 0 because this isn't an error case we just didn't need to output
        if test "$level" = debug
            set -q DEBUG; or return 0
        end
        # If no message was provided we will go ahead and return
        string length -q "$msg"; or return 0

        set_color (string split ' ' $color)[1]
        printf '[%-'$level_length's]: %s\n' "$level" "$msg" >&2
        set_color normal
    end

    function ___color_select
        set -l provided_level (string lower $argv[1])
        switch "$provided_level"
            case debug
                set -q LOG_COLOR_DEBUG; and echo "$LOG_COLOR_DEBUG"; or echo green
            case info
                set -q LOG_COLOR_INFO; and echo "$LOG_COLOR_INFO"; or echo blue
            case error
                set -q LOG_COLOR_ERROR; and echo "$LOG_COLOR_ERROR"; or echo red
            case warn
                set -q LOG_COLOR_WARN; and echo "$LOG_COLOR_WARN"; or echo yellow
        end
    end

    getopts $argv | while read -l key value
        switch $key
            case C color
                set color "$value"
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

    switch (count $argv)
        case 1
            set msg "$argv[1]"
        case 2
            set level "$argv[1]"
            set msg "$argv[2]"
        case 3
            set level "$argv[1]"
            set label "$argv[2]"
            set msg "$argv[3]"
    end

    test -z "$label"; and set -x color (___color_select "$level")
    test -n "$label"; and set msg "($label) $msg"

    ___log --color "$color" --message "$msg" --level "$level"
end
