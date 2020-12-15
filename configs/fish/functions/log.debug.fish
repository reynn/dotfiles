#!/usr/bin/env fish

function log.debug -d "Log a debug message"
    set -l label ''
    set -l msg ''
    set -lx color 'blue'

    function ___usage
        set -l help_args '-a' "Log a debug message [color: $color]"
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
    # Return 0 because this isn't an error case we just didn't need to output
    set -q DEBUG; or return 0

    # If no message was provided we will go ahead and return
    test -z $msg; and test -z $label; and return 0

    set_color $color
    echo -e "[DEBUG]"(test -n $label; and echo "($label)"; or echo "")": $msg" >&2
    set_color normal
end
