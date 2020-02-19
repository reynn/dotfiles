#!/usr/bin/env zsh

#+============================================================================+
# Docker
#+============================================================================+

#+============================================================================+
# Docker: Build
#+============================================================================+

alias dok_bui_rel="DOCKER_CONTENT_TRUST=1 docker build"

#+============================================================================+
# Docker: Run
#+============================================================================+

alias _dok_run_base='docker run --rm -it -v $PWD:/app -w /app'
alias dok_run_bash='_dok_run_base --entrypoint=/bin/bash'
alias dok_run_ash='_dok_run_base --entrypoint=/bin/ash'
alias dok_run_sh='_dok_run_base --entrypoint=/bin/sh'
alias dok_run='dok_run_sh'

alias dok_run_alpine='dok_run_ash alpine:3.11'
alias dok_run_go='dok_run_bash "golang:${LANGUAGES_GO_VERSION}-buster"'
alias dok_run_kubectl='dok_run_bash -v $HOME/.kube:/root/.kube -u 0:0 bitnami/kubectl'
alias dok_run_python='dok_run_bash "python:${LANGUAGES_PYTHON_VERSION}"'
alias dok_run_rust='dok_run_bash "rust:${LANGUAGES_RUST_VERSION}"'
alias dok_run_ubuntu='dok_run_bash ubuntu:19.10'

alias dok_run_redis='docker run --name redis -d -p 6379:6379 redis:alpine3.10'

#+============================================================================+
# Docker: Function Aliases
#+============================================================================+

alias dok_retag="docker_retag_and_push"
alias dok_gen_version='_dok_run_base quay.io/reynn/docker-versioner:0.9.0'

#+============================================================================+
# Docker: Listings
#+============================================================================+

alias dok_ls_im='docker image ls -a'
alias dok_ls_co='docker container ls -a'

#+============================================================================+
# Docker: Cleanup
#+============================================================================+

alias dok_cln_con='docker container rm $(docker container ls -qa)'
alias dok_cln_all_con='docker container rm -f $(docker container ls -qa)'
alias dok_cln_img='docker image rm $(docker image ls -q)'
alias dok_cln_all_img='docker image rm -f $(docker image ls -q)'
