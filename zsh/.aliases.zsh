#!/bin/sh -xe
FP="$DFP/zsh/.aliases.zsh"

# -----------------------------------------------------------------------------
#### File Aliases -------------------------------------------------------------
alias AE="vim $FP" # alias edit
alias AR="source $FP" # alias reload

# Global Aliases --------------------------------------------------------------
alias ZR="sh -c \"$DFP/install.sh\""
alias C='wc -l'
alias H='head'
alias L="less"
alias N="/dev/null"
alias S='sort'
alias G='rg'

# -----------------------------------------------------------------------------
# Tool aliases ----------------------------------------------------------------
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
## Tool:terminal aliases -------------------------------------------------------
alias tock="tock -cms -C 1 -f 'Day %j of %Y -- (%Y.%m.%d)'"
alias sterns="stern"
alias stern="stern -E linkerd-proxy"

# -----------------------------------------------------------------------------
# Unix aliases ----------------------------------------------------------------
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
## UNIX:General aliases -------------------------------------------------------
alias eecho='echo -e'
alias path='eecho ${PATH//:/\\n}'
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
alias chall='sudo chmod -R u=rwx,g=rwx,o=rwx ./*; sudo chown -R "$(id -u):$(id -g)" ./*'

# -----------------------------------------------------------------------------
## UNIX:Readability aliases ---------------------------------------------------
alias df='df -h'
alias du='du -h -d 2'

# -----------------------------------------------------------------------------
## UNIX:Networking aliases ----------------------------------------------------
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# -----------------------------------------------------------------------------
## UNIX:Text aliases ----------------------------------------------------------
alias lower="tr '[A-Z]' '[a-z]'"
alias upper="tr '[a-z]' '[A-Z]'"

# -----------------------------------------------------------------------------
# Docker aliases --------------------------------------------------------------
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
## Docker:build aliases -------------------------------------------------------
alias dok_bui_rel="DOCKER_CONTENT_TRUST=1 docker build"

# -----------------------------------------------------------------------------
## Docker:funcs aliases -------------------------------------------------------
alias dok_retag="docker_retag_and_push"
alias dok_gen_version='docker run --rm -v $PWD:$PWD -w $PWD quay.io/reynn/docker-versioner:0.9.0'

# -----------------------------------------------------------------------------
## Docker:run aliases ---------------------------------------------------------
alias dok_run_bash='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/bash'
alias dok_run_ash='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/ash'
alias dok_run_sh='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/sh'
alias dok_run='dok_run_sh'

alias dok_run_alpine='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/ash alpine:3.9'
alias dok_run_go='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/bash quay.io/reynn/golang:latest'
alias dok_run_kubectl='docker run --rm -it -v $PWD:$PWD -v $HOME/.kube:/root/.kube -w $PWD -u 0:0 --entrypoint=/bin/bash bitnami/kubectl'
alias dok_run_python='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/bash python:3.7'
alias dok_run_rust='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/bash rust:1.35.0'
alias dok_run_ubuntu='docker run --rm -it -v $PWD:$PWD -w $PWD --entrypoint=/bin/bash ubuntu:19.04'

# -----------------------------------------------------------------------------
## Docker:list aliases --------------------------------------------------------
alias dok_ls_im="docker image ls -a"
alias dok_ls_co="docker container ls -a"

# -----------------------------------------------------------------------------
## Docker:clean aliases -------------------------------------------------------
alias dok_cln_con="docker container rm \$(docker container ls -qa)"
alias dok_cln_all_con="docker container rm -f \$(docker container ls -qa)"
alias dok_cln_img="docker image rm \$(docker image ls -q)"
alias dok_cln_all_img="docker image rm -f \$(docker image ls -q)"

# -----------------------------------------------------------------------------
# SCM aliases -----------------------------------------------------------------
alias gitclean='git reset --hard && git clean -fx'
