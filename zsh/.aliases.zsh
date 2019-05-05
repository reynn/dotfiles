#!/bin/sh -xe
FP="$DFP/zsh/.aliases.zsh"

# -----------------------------------------------------------------------------
#### File Aliases -------------------------------------------------------------
alias AE="vim $FP" # alias edit
alias AR="source $FP" # alias reload

# Global Aliases --------------------------------------------------------------
alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ZR="sh -c \"$DFP/install.sh\""
alias C='| wc -l'
alias H='| head'
alias L="| less"
alias N="| /dev/null"
alias S='| sort'
alias G='| grep'

# -----------------------------------------------------------------------------
# Unix aliases ----------------------------------------------------------------
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
## UNIX:General aliases -------------------------------------------------------
alias cecho='echo -e'
alias path='cecho ${PATH//:/\\n}'

# -----------------------------------------------------------------------------
## UNIX:Movement aliases ------------------------------------------------------
alias ols="ls -la"
alias l="exa -lah --group-directories-first --time-style long-iso --color-scale"
alias ll="l --git-ignore --tree "
alias cls="clear;ls"

# -----------------------------------------------------------------------------
## UNIX:Directory aliases -----------------------------------------------------
alias mkdir="mkdir -p"

# -----------------------------------------------------------------------------
## UNIX:Readability aliases ---------------------------------------------------
alias df='df -h'
alias du='du -h -d 2'

# -----------------------------------------------------------------------------
## UNIX:Networking aliases ----------------------------------------------------
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# -----------------------------------------------------------------------------
# Docker aliases --------------------------------------------------------------
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
## Docker:run aliases ---------------------------------------------------------
alias dr='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/bash'
alias dra='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/ash alpine'
alias drg='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/bash golang'
alias drk='docker run --rm -it -v $PWD:$PWD -v $HOME/.kube:/root/.kube -w $PWD -u 0:0 --entrypoint=/bin/bash bitnami/kubectl'
alias drp='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/bash python'
alias dru='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/bash ubuntu'

# -----------------------------------------------------------------------------
## Docker:image aliases -------------------------------------------------------
alias di="docker image ls -a"

# -----------------------------------------------------------------------------
## Docker:container aliases ---------------------------------------------------
alias dc="docker container ls -a"

# -----------------------------------------------------------------------------
## Docker:clean aliases -------------------------------------------------------
alias dclc="docker container rm \$(docker container ls -qa)"
alias dclca="docker container rm -f \$(docker container ls -qa)"
alias dcli="docker image rm \$(docker image ls -q)"
alias dclia="docker image rm -f \$(docker image ls -q)"

# -----------------------------------------------------------------------------
# SCM aliases -----------------------------------------------------------------
alias gitclean='git reset --hard && git clean -fx'
