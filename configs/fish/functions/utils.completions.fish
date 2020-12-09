function utils.completions -d 'Show completions that have been added to our dotfiles repo'
    set -lx show_all_completions 'false'

    function ___usage
        set -l help_args '-a' 'Show completions that have been added to our dotfiles repo'
        set -a help_args '-f' "a|all|Iterate through all `fish_complete_path`s to list completions|$show_all_completions"
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case a all
                set show_all_completions 'true'
            case h help
                ___usage
                return 0
            case v verbose
                set -x DEBUG 'true'
        end
    end

    function __list_completions
        if test -x (command -s fd)
            fd -tf -e fish . $argv
        end
    end

    if test "$show_all_completions" = 'true'
        for completion_path in $fish_complete_path
            log.info -m "Listing completions available in $completion_path"
            __list_completions $completion_path
        end
    end
end
