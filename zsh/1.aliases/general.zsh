#!/usr/bin/env zsh

# Global Aliases --------------------------------------------------------------
alias C='wc -l'
alias H='head'
alias L='less'
alias N='/dev/null'
alias S='sort'
alias G='rg'
alias BIN_DOWNLOADS='cat $DFP/ansible/vars/0-primary-vars.yaml | yq -r ".bin_downloads[].repository" | sort'
alias reynn='cd $REYNN'
alias bins='cd $DIR_BINS'

# -----------------------------------------------------------------------------
# General aliases -------------------------------------------------------------
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
## General aliases ------------------------------------------------------------
alias paths='echo -e ${PATH//:/\\n}'
alias please='sudo'
alias kill_ssh_agents='ps aux | grep ssh-agent | grep -v grep | awk "{print \$2}" | xargs kill -9'

# -----------------------------------------------------------------------------
## Movement aliases -----------------------------------------------------------
alias ols='ls -la'
alias l='exa -lah --git-ignore --group-directories-first --time-style long-iso --color-scale'
alias ll='l --tree'
alias cl='clear;l'
alias cls='clear;ls'

# -----------------------------------------------------------------------------
## Directory aliases ----------------------------------------------------------
alias mkdir='mkdir -p'
alias chownall='sudo chown -R "$(id -u):$(id -g)" ./*'
alias chmodall='sudo chmod -R u=rwx,g=rw,o=rw ./*'
alias chall='chownall; chmodall;'

# -----------------------------------------------------------------------------
## Readability aliases --------------------------------------------------------
alias df='df -h'
alias du='du -h -d 2'

# -----------------------------------------------------------------------------
## Networking aliases ---------------------------------------------------------
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en0'

# -----------------------------------------------------------------------------
# SCM aliases -----------------------------------------------------------------
alias gitclean='git reset --hard && git clean -fx'
