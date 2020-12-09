#!/usr/bin/env fish

function log.info -d "Log a special information message"
    set -l label ''
    set -l msg ''
    set -lx color 'cyan'

    function ___usage
        set -lx help_args '-a' "Log an informational message [color: $color]"
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

    # If message wasn't provided by flag see if there is an argument
    test -z $msg; and set msg "$argv"

    # If no message was provided we will go ahead and return
    test -z $msg; and return 0

    set_color $color
    echo -e "[INFO]"(test -n $label; and echo "($label)"; or echo '')": $msg"
    set_color normal
end
