#!/usr/bin/env fish

function __log -d "HELPER for logging"
    set -x level
    set -x msg
    set -x color normal
    set -x level_length 6

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
