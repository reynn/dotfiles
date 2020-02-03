#!/usr/bin/env zsh

DEBUG="${DEBUG:-false}"
GFP="$HOME/git"
REYNN="$GFP/github.com/reynn"
DFP="$REYNN/dotfiles"
DIR_BINS="$HOME/.bins"

fpath=($DFP/zsh/6.completions $fpath)
HELP_JSON="$DFP/zsh/function_help.json"
IMPORT_DIRECTORIES=(
  $($DIR_BINS/fd -t d -d1 -E '5.hosts' -E '6.completions' . $DFP/zsh)
  $DFP/zsh/5.hosts/$CURRENT_HOST
)
SSH_IDENTITIES=(id_rsa)

export DEBUG
export DFP
export DIR_BINS
export fpath
export GFP
export HELP_JSON
export IMPORT_DIRECTORIES
export REYNN
export SSH_IDENTITIES
