function git.checkout.branch -d "Show a list of branches to select for checkout"
    set -l branches (
      git --no-pager branch --all --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" | sed '/^$/d'
    )
    set -l tags ( git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}' )
    set -l target (string split ' ' "$branches $tags" | fzf --no-hscroll --no-multi --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'" )
    if test -n $target
        git checkout (echo "$target" | awk '{print $2}')
    end
end
