#!/usr/bin/env fish

function __log -d "HELPER for logging"
    set -x level
    set -x msg
    set -x color 'normal'
    set -x level_length '7'

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
                set -x DEBUG 'true'
        end
    end

    # If no message was provided we will go ahead and return
    string length -q "$msg"; or return 0

    set_color (string split ' ' $color)[1]
    printf "[%-8s]: %s\n" "$level" "$msg"
    set_color normal
end
