#!/usr/bin/env fish

# set fish_trace on

set -gx TERM screen-256color
set -gx EDITOR nvim

set -gx reynn_fish_home "$HOME/git/github.com/reynn/dotfiles/configs/fish"
# Add our dotfiles path to the list fish uses when loading functions
set -p fish_function_path "$reynn_fish_home/functions"
# Same as above but for completions
set -p fish_complete_path "$reynn_fish_home/completions"

# Aliases
alias cp 'cp -v'
alias mkdir 'mkdir -p'
alias mv 'mv -v'
alias rm 'rm -iv'
alias history 'builtin history --show-time="%m/%e %H:%M:%S | "'
alias l 'lsd -l'
alias ll 'l --tree'

# Abbreviations
abbr --add dotdot --regex '^\.\.+$' --function dot_dot_expand
abbr --add !! --position anywhere --function last_history_item

# set fish_trace off
