#!/usr/bin/env fish

function git.commit.reset -d 'Show a list of commits in MRU order. Will use selected commit to `git reset --hard <SHA>`'
    set -lx target ''
    set -lx fzf_preview 'git show --color --format="medium" {}'
    set -lx result_count '30'

    function ___usage
        set -l help_args -a "Show a list of commits in MRU order. Will use selected commit to `git reset --hard <SHA>`"
        set -a help_args -f "p|preview|Overwrite the default FZF preview command|$fzf_preview"
        set -a help_args -f "n|max-count|Max number of commits to show in the FZF list|$result_count"
        set -a help_args -f "s|sha|Provide a SHA instead of using FZF to select one|$target"
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case s sha t target
                set target $value
            case p preview
                set fzf_preview $value
            case n 'max-count'
                set result_count $value
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

    # If the current target is empty we start a FZF selector
    if test -z "$target"
        set target (git rev-list -n $result_count --date-order origin | fzf --select-1 --preview "$fzf_preview")
    end

    if test -n "$target"
        git reset --hard $target
    end
end
