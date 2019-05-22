# zmodload zsh/zprof # uncomment to debug performance issues with zsh startup
export GFP="$HOME/git"
export DFP="$GFP/reynn/dotfiles"
export DIR_BINS="$HOME/.bins"
FP="$DFP/zsh/.zshrc"

# -----------------------------------------------------------------------------
#### File Aliases -------------------------------------------------------------
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
# export DEBUG="true"
function import_zsh_files() {
  debugEcho "> Importing zsh files..."
  for d in $1; do
    debugEcho ">> Searching dir :$d"
    for f in $(find $DFP/$d -type f -name "*.zsh"); do
      debugEcho ">>> Sourcing :: $f"
      source $f
    done
  done
}
export IMPORT_DIRECTORIES=(zsh)

import_zsh_files $IMPORT_DIRECTORIES

if test -r "$HOME/.gimme/envs/latest.env"; then
  source $HOME/.gimme/envs/latest.env
fi

test -r "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

test -r $DFP/zsh/.fzf.zsh && source $DFP/zsh/.fzf.zsh

# zprof # uncomment to debug performance issues with zsh startup
