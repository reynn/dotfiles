# Aliases

## Program rename -----------------------------------------------------------------------
alias vim 'command nvim'
alias "vi" 'command vim'
alias sterns 'stern'
alias stern 'stern -E linkerd-proxy'
## AWS ----------------------------------------------------------------------------------
alias aws_ssm_session 'aws ssm start-session --target '
alias aws_ec2_untagged 'aws ec2 describe-instances --output text --query "Reservations[].Instances[?!not_null(Tags[?Key == \"Name\"].Value)] | [].InstanceId" | tr "\t" "\n"'
## Global -------------------------------------------------------------------------------
alias C 'wc -l'
alias G 'grep'
alias H 'head'
alias L 'less'
alias S 'sort'
alias grep 'rg -i'
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
alias cp 'cp -i'
alias download_remote_directory 'wget -c -r -np -l1 -e robots=off -R "fileicon.png*" -R "index.html*" -nd'
alias mkdir 'mkdir -p'
alias mv 'mv -i'
alias rmd 'rm -fI'
alias rm 'rm -iv'
## Readability --------------------------------------------------------------------------
alias df 'df -h'
alias du 'du -h -d 2'
## Docker -------------------------------------------------------------------------------
### Docker: Function --------------------------------------------------------------------
alias dock_retag "docker_retag_and_push"
alias dock_gen_version '_dock_run_base quay.io/reynn/docker-versioner:0.9.0'
### Docker: Run -------------------------------------------------------------------------
alias dock_run_redis 'docker run --name redis -d -p 6379:6379 redis:alpine3.12'
