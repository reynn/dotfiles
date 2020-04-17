#!/usr/bin/env zsh

#+============================================================================+
# Docker
#+============================================================================+

#+============================================================================+
# Docker: Build
#+============================================================================+

alias dock_bui_rel="DOCKER_CONTENT_TRUST=1 docker build"

#+============================================================================+
# Docker: Cleanup
#+============================================================================+

alias dock_cln_con='docker container rm $(docker container ls -qa)'
alias dock_cln_all_con='docker container rm -f $(docker container ls -qa)'
alias dock_cln_img='docker image rm $(docker image ls -q)'
alias dock_cln_all_img='docker image rm -f $(docker image ls -q)'

#+============================================================================+
# Docker: Function Aliases
#+============================================================================+

alias dock_retag="docker_retag_and_push"
alias dock_gen_version='_dock_run_base quay.io/reynn/docker-versioner:0.9.0'

#+============================================================================+
# Docker: Listings
#+============================================================================+

alias dock_ls_im='docker image ls -a'
alias dock_ls_co='docker container ls -a'

#+============================================================================+
# Docker: Run
#+============================================================================+

alias _dock_run_base='docker run --rm -it -v $PWD:/app -w /app'
alias dock_run_bash='_dock_run_base --entrypoint=/bin/bash'
alias dock_run_ash='_dock_run_base --entrypoint=/bin/ash'
alias dock_run_sh='_dock_run_base --entrypoint=/bin/sh'
alias dock_run='dock_run_sh'

alias dock_run_alpine='dock_run_ash alpine:3.11'
alias dock_run_go='dock_run_bash "golang:${LANGUAGES_GO_VERSION}-buster"'
alias dock_run_kubectl='dock_run_bash -v $HOME/.kube:/root/.kube -u 0:0 bitnami/kubectl'
alias dock_run_python='dock_run_bash "python:${LANGUAGES_PYTHON_VERSION}"'
alias dock_run_rust='dock_run_bash "rust:${LANGUAGES_RUST_VERSION}"'
alias dock_run_ubuntu='dock_run_bash ubuntu:19.10'

alias dock_run_redis='docker run --name redis -d -p 6379:6379 redis:alpine3.10'
