FP="$DFP/zsh/.exports.zsh"

# -----------------------------------------------------------------------------
#### File Aliases -------------------------------------------------------------
alias EE="vim $FP" # alias edit
alias ER="source $FP" # alias reload

# -----------------------------------------------------------------------------
# UNIX exports ----------------------------------------------------------------
export SSH_KEY_PATH='~/.ssh/rsa_id'
export EDITOR='vim'
local paths=(
  "$HOME/.bins"
  "$HOME/.cargo/bin"
  "$DFP/python"
  "$HOME/Library/Python/3.7/bin"
  "$HOME/.npm-global/bin"
  "/Library/Frameworks/Python.framework/Versions/3.7/bin"
  "$HOME/.krew/bin"
  "$HOME/go/bin"
  "$GFP/thecasualcoder/kube-fzf"
  "$GFP/bin"
  "$GFP/junegunn/fzf/bin"
  "/usr/local/go/bin"
  "/usr/local/MacGPG2/bin"
  "/usr/local/bin"
  "/usr/bin"
  "/bin"
  "/usr/sbin"
  "/sbin"
)
join tmpPath ":" "${paths[@]}"
export PATH="$tmpPath"

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768'
export HISTFILESIZE="$HISTSIZE"
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth'

# -----------------------------------------------------------------------------
# K8S exports -----------------------------------------------------------------
export K8S_DEFAULT_NAMESPACE='development'
export HELM_VALUES_PATH="$GFP/reynn/k8s/helm/values"

# -----------------------------------------------------------------------------
# GO exports ------------------------------------------------------------------
export GOPATH="$HOME/go"
export GO111MODULE='on'

# -----------------------------------------------------------------------------
# Git exports -----------------------------------------------------------------
# export GIT_CONFIG="$DFP/git/gitconfig"

# -----------------------------------------------------------------------------
# ZSH Exports -----------------------------------------------------------------
export UPDATE_ZSH_DAYS=3
