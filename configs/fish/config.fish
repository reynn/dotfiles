#!/usr/bin/env fish

status is-login
set -l login_shell $status
status is-interactive
set -l interactive_shell $status

if test $interactive_shell -ne 0
    exit 0
end

set -gx reynn_fish_home "$HOME/git/github.com/reynn/dotfiles/configs/fish"
set -gx TERM 'screen-256color'
set -gx EDITOR 'nvim'
set -gp fish_function_path "$reynn_fish_home/functions"
set -gp fish_complete_path "$reynn_fish_home/completions"

## Load any secrets
utils.source "$DFP/.host/$hostname.fish"
utils.source "$DFP/.secrets/$hostname.fish"

# Escape before loading paths
if test $login_shell -ne 0
    exit 0
end

utils.source "$GFP/github.com/junegunn/fzf/shell/key-bindings.fish"

## FZF
set -xg FZF_DEFAULT_OPTS '--height 50%'
set -gp FZF_DEFAULT_OPTS '--border'
set -gp FZF_DEFAULT_OPTS '--layout=reverse'
# -- FZF theme: Gruvbox Light
# set -gp FZF_DEFAULT_OPTS '--color=fg:#282828,bg:#fbf1c7,hl:#076678,fg+:,bg+:,hl+:#458588'
# set -gp FZF_DEFAULT_OPTS '--color=info:#427b58,prompt:#8f3f71,pointer:#9d0006,marker:#689d69,spinner:#98971a,header:#cc241d'
# -- FZF theme: Gruvbox Dark
set -gp FZF_DEFAULT_OPTS '--color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f'
set -gp FZF_DEFAULT_OPTS '--color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'
# -- FZF theme: Nord
# set -gp FZF_DEFAULT_OPTS '--color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C'
# set -gp FZF_DEFAULT_OPTS '--color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B'
set -xg FZF_DEFAULT_COMMAND 'fd --type f --no-ignore --hidden --exclude .git'
set -xg FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# Aliases
alias cp 'cp -i'
alias mkdir 'mkdir -p'
alias mv 'mv -i'
alias rm 'rm -iv'

## Initialize starship if available
if test -e (command -s starship; or command -v starship)
    starship init fish | source
end
