# Aliases

## General ------------------------------------------------------------------------------
alias l "exa -la --group-directories-first"
alias "rm" "rm -v"
## Program rename -----------------------------------------------------------------------
alias vim nvim
alias "vi" vim
alias sterns 'stern'
alias stern 'stern -E linkerd-proxy'
## AWS ----------------------------------------------------------------------------------
alias aws_ssm_session 'aws ssm start-session --target '
alias aws_ec2_untagged 'aws ec2 describe-instances --output text --query "Reservations[].Instances[?!not_null(Tags[?Key == \`Name\`].Value)] | [].InstanceId" | tr "\t" "\n"'
## Global -------------------------------------------------------------------------------
alias BIN_DOWNLOADS 'yq r $DFP/ansible/vars/0-primary-vars.yaml "bin_downloads[*].repository" | tr "\- " "\0" | sort'
alias C 'wc -l'
alias G 'grep'
alias H 'head'
alias L 'less'
alias S 'sort'
alias bins 'cd $DIR_BINS'
alias grep 'rg -i'
alias izf 'import_zsh_files $IMPORT_DIRECTORIES'
alias reynn 'cd $REYNN'
## General ------------------------------------------------------------------------------
alias kill_ssh_agents 'ps aux | grep ssh-agent | awk "{print \$2}" | xargs kill -9'
alias paths 'string split0 ":" $PATH | tail -n +2'
alias tokens 'env | sort | rg -i token'
alias please 'sudo'
## Movement -----------------------------------------------------------------------------
alias ols 'ls -la'
alias l 'exa -lah --git-ignore --group-directories-first --time-style long-iso --color-scale'
alias ll 'l --tree'
alias cl 'clear;l'
alias cls 'clear;ls'
## Directory ----------------------------------------------------------------------------
alias chall 'chownall; chmodall;'
alias chmodall 'sudo chmod -R u=rwx,g=rw,o=rw ./*'
alias chownall 'sudo chown -R "(id -u):(id -g)" ./*'
alias cp 'cp -i'
alias download_remote_directory 'wget -c -r -np -l1 -e robots=off -R "fileicon.png*" -R "index.html*" -nd'
alias mkdir 'mkdir -p'
alias mv 'mv -i'
alias rmd 'rm -fI'
alias rm 'rm -iv'
## Readability --------------------------------------------------------------------------
alias df 'df -h'
alias du 'du -h -d 2'
## Networking ---------------------------------------------------------------------------
alias remoteip 'dig +short myip.opendns.com @resolver1.opendns.com'
alias localip 'ipconfig getifaddr en0'
## Git ----------------------------------------------------------------------------------
alias gitclean 'git reset --hard; git clean -fx'
## Docker -------------------------------------------------------------------------------
### Docker: Build -----------------------------------------------------------------------
alias dock_bui_rel "DOCKER_CONTENT_TRUST=1 docker build"
### Docker: Cleanup ---------------------------------------------------------------------
alias dock_cln_con 'docker container rm (docker container ls -qa)'
alias dock_cln_all_con 'docker container rm -f (docker container ls -qa)'
alias dock_cln_img 'docker image rm (docker image ls -q)'
alias dock_cln_all_img 'docker image rm -f (docker image ls -q)'
### Docker: Function --------------------------------------------------------------------
alias dock_retag "docker_retag_and_push"
alias dock_gen_version '_dock_run_base quay.io/reynn/docker-versioner:0.9.0'
### Docker: Listings --------------------------------------------------------------------
alias dock_ls_im 'docker image ls -a'
alias dock_ls_co 'docker container ls -a'
### Docker: Run -------------------------------------------------------------------------
alias _dock_run_base 'docker run --rm -it -v $PWD:/app -w /app'
alias dock_run_bash '_dock_run_base --entrypoint=/bin/bash'
alias dock_run_ash '_dock_run_base --entrypoint=/bin/ash'
alias dock_run_sh '_dock_run_base --entrypoint=/bin/sh'
alias dock_run 'dock_run_sh'
alias dock_run_alpine 'dock_run_ash alpine:3.12'
alias dock_run_go 'dock_run_bash "golang:$LANGUAGES_GO_VERSION-buster"'
alias dock_run_python 'dock_run_bash "python:$LANGUAGES_PYTHON_VERSION"'
alias dock_run_rust 'dock_run_bash "rust:$LANGUAGES_RUST_VERSION"'
alias dock_run_kubectl 'dock_run_bash -v $HOME/.kube:/root/.kube -u 0:0 bitnami/kubectl'
alias dock_run_ubuntu 'dock_run_bash ubuntu:20.04'
alias dock_run_redis 'docker run --name redis -d -p 6379:6379 redis:alpine3.12'
