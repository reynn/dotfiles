#!/bin/usr/env zsh

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
alias dok_run_bash='docker run --rm -it -v $PWD:/app -w /app --entrypoint=/bin/bash'
alias dok_run_ash='docker run --rm -it -v $PWD:/app -w /app --entrypoint=/bin/ash'
alias dok_run_sh='docker run --rm -it -v $PWD:/app -w /app --entrypoint=/bin/sh'
alias dok_run='dok_run_sh'

alias dok_run_alpine='docker run --rm -it -v $PWD:/app -w /app --entrypoint=/bin/ash alpine:3.9'
alias dok_run_go='docker run --rm -it -v $PWD:/app -w /app --entrypoint=/bin/bash quay.io/reynn/golang:latest'
alias dok_run_kubectl='docker run --rm -it -v $PWD:/app -v $HOME/.kube:/root/.kube -w /app -u 0:0 --entrypoint=/bin/bash bitnami/kubectl'
alias dok_run_python='docker run --rm -it -v $PWD:/app -w /app --entrypoint=/bin/bash python:3.8'
alias dok_run_rust='docker run --rm -it -v $PWD:/app -w /app --entrypoint=/bin/bash rust:1.39.0'
alias dok_run_ubuntu='docker run --rm -it -v $PWD:/app -w /app --entrypoint=/bin/bash ubuntu:19.10'

alias dok_run_redis='docker run --name redis -d -p 6379:6379 redis:alpine3.10'

# -----------------------------------------------------------------------------
## Docker:list aliases --------------------------------------------------------
alias dok_ls_im='docker image ls -a'
alias dok_ls_co='docker container ls -a'

# -----------------------------------------------------------------------------
## Docker:clean aliases -------------------------------------------------------
alias dok_cln_con='docker container rm $(docker container ls -qa)'
alias dok_cln_all_con='docker container rm -f $(docker container ls -qa)'
alias dok_cln_img='docker image rm $(docker image ls -q)'
alias dok_cln_all_img='docker image rm -f $(docker image ls -q)'
