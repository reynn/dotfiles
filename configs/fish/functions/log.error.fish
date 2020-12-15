#!/usr/bin/env fish

function log.error -d "Log a error message"
    set -l label ''
    set -l msg ''
    set -lx color $fish_color_error

    function ___usage
        set -l help_args '-a' "Log an error message [color: $color]"
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case l label
                set label $value
            case m message
                set msg $value
            case h help
                ___usage
                return 0
            case v verbose
                set -x DEBUG 'true'
        end
    end

    # If no message was provided we will go ahead and return
    test -z $msg; and return 0

    set_color $color
    echo -e "[ERROR]"(test -n $label; and echo "($label)"; or echo "")": $msg" >&2
    set_color normal
end
