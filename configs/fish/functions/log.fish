#!/usr/bin/env fish

function log -d "Log a message"
    set -lx log_levels debug info warn error
    set -lx level info
    set -lx color blue
    set -lx label
    set -lx msg

    function ___usage
        set -l help_args -a "Log a message"
        set -a help_args -f 'l|label|An extra label to include at the beginning, in `()`'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case _
                set -a msg "$value"
            case C color
                set color "$value"
            case L level
                contains -- $log_levels (string lower "$value"); and set level (string lower "$value")
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

    __log --color "$color" --message "$msg" --level "$level"
end
