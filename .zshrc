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
source $DFP/zsh/.functions.zsh
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
ZSH_THEME='powerlevel9k/powerlevel9k'
POWERLEVEL9K_PROMPT_ON_NEWLINE='true'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir go_version vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv command_execution_time kubecontext aws status dir_writable)
HYPHEN_INSENSITIVE='true'
COMPLETION_WAITING_DOTS='true'

plugins=()
test -r "$(which aws)" && plugins+=('aws')
test -r "$(which docker)" && plugins+=('docker')
test -r "$(which git)" && plugins+=('git')

# -----------------------------------------------------------------------------
## ZSH:Init -------------------------------------------------------------------
export ZSH="$GFP/robbyrussell/oh-my-zsh"
source $GFP/robbyrussell/oh-my-zsh/oh-my-zsh.sh

# -----------------------------------------------------------------------------
## ZSH:Functions --------------------------------------------------------------
prompt_go_version() {
  local go_version
  local go_path
  go_version=$(go version 2>/dev/null | sed -E "s/.*(go[0-9.]*).*/\1/")
  go_path=$(go env GOPATH 2>/dev/null)

  if [[ -n "$go_version" && ("${PWD##$go_path}" != "$PWD" || -f "$PWD/go.mod") ]]; then
    "$1_prompt_segment" "$0" "$2" "green" "grey93" "$go_version" "GO_ICON"
  fi
}

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

local sourcePaths=(
  "$HOME/.gimme/envs/latest.env"
  "$HOME/.iterm2_shell_integration.zsh"
  "$GFP/thecasualcoder/kube-fzf/kube-fzf.sh"
)

debugEcho "> Sourcing additional files..."
for sourceable in $sourcePaths; do
  debugEcho ">> Checking :$sourceable"
  if test -r "$sourceable"; then
    debugEcho ">>> Source :$sourceable"
    source "$sourceable"
  fi
done

# zprof # uncomment to debug performance issues with zsh startup
