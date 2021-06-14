#!/usr/bin/env fish

# set -x DEBUG 'true'

status is-login
set -l login_shell $status
status is-interactive
set -l interactive_shell $status

if test $interactive_shell -ne 0
    exit 0
end

set -gx reynn_fish_home "$HOME/git/github.com/reynn/dotfiles/configs/fish"
set -gx TERM screen-256color
set -gx EDITOR nvim
set -gp fish_function_path "$reynn_fish_home/functions"
set -gp fish_complete_path "$reynn_fish_home/completions"

# Escape before loading paths
if test $login_shell -ne 0
    exit 0
end

# Aliases
alias cp 'cp -i'
alias mkdir 'mkdir -p'
alias mv 'mv -i'
alias rm 'rm -iv'
alias history 'builtin history --show-time="%m/%e %H:%M:%S | "'
alias l 'exa -lah --git-ignore --icons --git --group-directories-first --time-style long-iso --color-scale'
alias ll 'l --tree --level 3'

test -e $HOME/.iterm2_shell_integration.fish; and source $HOME/.iterm2_shell_integration.fish
