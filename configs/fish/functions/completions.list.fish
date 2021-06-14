#!/usr/bin/env fish

function completions.list -d 'Show completions that have been added to our dotfiles repo'
    set -x show_all_completions false

    function ___usage
        set -l help_args -a 'Show completions that have been added to our dotfiles repo'
        set -a help_args -f "a|all|Iterate through all `fish_complete_path`s to list completions|$show_all_completions"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case a all
                set show_all_completions true
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

    function __list_completions
        if command.is_available -c fd
            fd -tf -e fish . $argv
        end
    end

    log debug "Show all completions: $show_all_completions"

    if test "$show_all_completions" = true
        for completion_path in $fish_complete_path
            log "Listing completions available in $completion_path"
            __list_completions $completion_path
        end
    else
        set -x custom_completions $fish_complete_path[1]
        log "Listing completions for $custom_completions"
        __list_completions "$custom_completions"
    end
end
