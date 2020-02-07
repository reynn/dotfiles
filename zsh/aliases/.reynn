#!/usr/bin/env zsh

# Global Aliases --------------------------------------------------------------
alias grep='rg'
alias C='wc -l'
alias H='head'
alias L='less'
alias N='/dev/null'
alias S='sort'
alias G='grep'
alias BIN_DOWNLOADS='yq r $DFP/ansible/vars/0-primary-vars.yaml "bin_downloads[*].repository" | tr "\- " "\0" | sort'
alias reynn='cd $REYNN'
alias bins='cd $DIR_BINS'
alias izf='import_zsh_files $IMPORT_DIRECTORIES'

# -----------------------------------------------------------------------------
# General aliases -------------------------------------------------------------
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
## General aliases ------------------------------------------------------------
alias paths='echo -e ${PATH//:/\\n}'
alias fpaths='echo $fpath | tr '\\ ' '\\n''
alias please='sudo'
alias kill_ssh_agents='ps aux | grep ssh-agent | awk "{print \$2}" | xargs kill -9'

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
alias download_remote_directory='wget -c -r -np -l1 -e robots=off -R "fileicon.png*" -R "index.html*" -nd'

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
