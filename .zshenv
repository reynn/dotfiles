#!/usr/bin/env zsh

export GFP="$HOME/git"
export DFP="$GFP/github.com/reynn/dotfiles"

source $DFP/zsh/.vars/.reynn
source $DFP/zsh/.hosts/.$CURRENT_HOST
source $DFP/zsh/functions/.reynn
source $DFP/zsh/functions/text.zsh

export IMPORT_DIRECTORIES=($DFP/zsh)
import_zsh_files $IMPORT_DIRECTORIES
