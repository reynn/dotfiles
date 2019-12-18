#!/bin/usr/env zsh

# Global Aliases --------------------------------------------------------------
alias C='wc -l'
alias H='head'
alias L='less'
alias N='/dev/null'
alias S='sort'
alias G='rg'
alias BIN_DOWNLOADS='cat $DFP/ansible/vars/0-primary-vars.yaml | yq -r ".bin_downloads[].repository" | sort'

# -----------------------------------------------------------------------------
# Unix aliases ----------------------------------------------------------------
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
## UNIX:General aliases -------------------------------------------------------
alias eecho='echo -e'
alias paths='eecho ${PATH//:/\\n}'
alias ccat='pygmentize -O style=stata-dark,full'
alias please='sudo'

# -----------------------------------------------------------------------------
## UNIX:Movement aliases ------------------------------------------------------
alias ols="ls -la"
alias l="exa -lah --git-ignore --group-directories-first --time-style long-iso --color-scale"
alias ll="l --tree"
alias cl="clear;l"
alias cls="clear;ls"

# -----------------------------------------------------------------------------
## UNIX:Directory aliases -----------------------------------------------------
alias mkdir="mkdir -p"
alias chall='sudo chmod -R u=rwx,g=rw,o=rw ./*; sudo chown -R "$(id -u):$(id -g)" ./*'

# -----------------------------------------------------------------------------
## UNIX:Readability aliases ---------------------------------------------------
alias df='df -h'
alias du='du -h -d 2'

# -----------------------------------------------------------------------------
## UNIX:Networking aliases ----------------------------------------------------
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# -----------------------------------------------------------------------------
# SCM aliases -----------------------------------------------------------------
alias gitclean='git reset --hard && git clean -fx'
