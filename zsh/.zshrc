# zmodload zsh/zprof # uncomment to debug performance issues with zsh startup
export GFP="$HOME/git"
export DFP="$GFP/reynn/dotfiles"
export DIR_BINS="$HOME/.bins"
FP="$DFP/zsh/.zshrc"

# -----------------------------------------------------------------------------
## File Aliases ---------------------------------------------------------------
alias ZE="vim $FP" # alias edit
alias ZR="source $FP" # alias reload

# -----------------------------------------------------------------------------
# Start -----------------------------------------------------------------------
source $DFP/zsh/.exports.zsh

# -----------------------------------------------------------------------------
## Start:Functions ------------------------------------------------------------
function debugEcho() {
  if test -n "$DEBUG"; then
    echo $@
  fi
}

# -----------------------------------------------------------------------------
# ZSH -------------------------------------------------------------------------
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
## ZSH:Config -----------------------------------------------------------------
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv go_version status dir_writable)
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

plugins=()
test -r "$(which kubectl)" && plugins+=('kubectl')
test -r "$(which aws)" && plugins+=('aws')
test -r "$(which docker)" && plugins+=('docker')
test -r "$(which git)" && plugins+=('git')

# -----------------------------------------------------------------------------
## ZSH:Init -------------------------------------------------------------------
export ZSH="$GFP/robbyrussell/oh-my-zsh"
source $GFP/robbyrussell/oh-my-zsh/oh-my-zsh.sh

# -----------------------------------------------------------------------------
# Imports ---------------------------------------------------------------------

# -----------------------------------------------------------------------------
## Imports:Function -----------------------------------------------------------
alias izf="import_zsh_files $IMPORT_DIRECTORIES"
function import_zsh_files() {
  for d in $1
  do
    debugEcho ">>Searching dir :$d"
    for f in $(ls -a $DFP/$d | rg -e '.(f|c|z)sh$')
    do
      local dfp_dir="$DFP/$d/$f"
      local home_dir="$HOME/$f"
      debugEcho ">>>Sourcing :: $dfp_dir"
      source $dfp_dir
      debugEcho ">>>Sourcing :: $home_dir"
      test -r $home_dir && source $home_dir
    done
  done
}
export IMPORT_DIRECTORIES=(zsh)

import_zsh_files $IMPORT_DIRECTORIES

if test -r "$DIR_BINS/gimme"; then
  echo "running gimme"
  eval "$(gimme stable)"
  clear
fi

test -r "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

test -r $DFP/zsh/.fzf.zsh && source $DFP/zsh/.fzf.zsh

# zprof # uncomment to debug performance issues with zsh startup
