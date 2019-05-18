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

alias update-dotfiles="ANSIBLE_CONFIG=$DFP/ansible.cfg ansible-playbook $DFP/playbook-config.yaml"

# -----------------------------------------------------------------------------
# Unix aliases ----------------------------------------------------------------
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
## UNIX:General aliases -------------------------------------------------------
alias eecho='echo -e'
alias path='eecho ${PATH//:/\\n}'
alias ccat='pygmentize'

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
## Docker:funcs aliases -------------------------------------------------------
alias retag="docker_retag_and_push"

# -----------------------------------------------------------------------------
## Docker:run aliases ---------------------------------------------------------
alias drbash='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/bash'
alias drash='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/ash'
alias drsh='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/sh'
alias dr='drbash'

alias gen_version='docker run --rm -v $PWD:$PWD -w $PWD quay.io/reynn/docker-versioner:0.9.0'

alias dra='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/ash alpine:3.9'
alias drg='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/bash golang:1.12'
alias drk='docker run --rm -it -v $PWD:$PWD -v $HOME/.kube:/root/.kube -w $PWD -u 0:0 --entrypoint=/bin/bash bitnami/kubectl'
alias drp='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/bash python:3.7'
alias dru='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/bash ubuntu:19.04'

# -----------------------------------------------------------------------------
## Docker:image aliases -------------------------------------------------------
alias d_ls_im="docker image ls -a"

# -----------------------------------------------------------------------------
## Docker:container aliases ---------------------------------------------------
alias d_ls_co="docker container ls -a"

# -----------------------------------------------------------------------------
## Docker:clean aliases -------------------------------------------------------
alias d_clean_co="docker container rm \$(docker container ls -qa)"
alias d_clean_all_co="docker container rm -f \$(docker container ls -qa)"
alias d_clean_im="docker image rm \$(docker image ls -q)"
alias d_clean_all_im="docker image rm -f \$(docker image ls -q)"

# -----------------------------------------------------------------------------
# SCM aliases -----------------------------------------------------------------
alias gitclean='git reset --hard && git clean -fx'
