FP="$DFP/zsh/.exports.zsh"

# -----------------------------------------------------------------------------
#### File Aliases -------------------------------------------------------------
alias EE="vim $FP" # alias edit
alias ER="source $FP" # alias reload

# -----------------------------------------------------------------------------
# UNIX exports ----------------------------------------------------------------
export SSH_KEY_PATH="~/.ssh/rsa_id"
export EDITOR='vim'
export PATH="$PATH:$HOME/go/bin"

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# -----------------------------------------------------------------------------
# K8S exports -----------------------------------------------------------------
export K8S_DEFAULT_NAMESPACE="development"

# -----------------------------------------------------------------------------
# GO exports ------------------------------------------------------------------
export GOPATH="$HOME/go"
export GO111MODULE="on"

# -----------------------------------------------------------------------------
# Git exports -----------------------------------------------------------------
export PATH="$PATH:$HOME/git/bin"
# export GIT_CONFIG="$DFP/git/gitconfig"

# -----------------------------------------------------------------------------
# ZSH Exports -----------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=3
