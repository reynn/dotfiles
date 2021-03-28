#!/usr/bin/env fish

function git.checkout -d 'Show a FZF list of branches to select for checkout'

    function ___usage
        set -l help_args -a "Show a FZF list of branches to select for checkout"
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
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

    set -x branches (
      git --no-pager branch --all --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" 2>/dev/null | sed '/^$/d'
    )
    set -l tags (git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}')
    set -l target (string split ' ' "$branches $tags" | fzf --no-hscroll --no-multi --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'" | awk '{print $2}')

    if test -n "$target"
        git checkout $target
    end
end
