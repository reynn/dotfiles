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
  "$DFP/scripts"
  "$HOME/.npm-global/bin"
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "$GFP/bin"
  "$GFP/github.com/thecasualcoder/kube-fzf"
  "$GFP/github.com/junegunn/fzf/bin"
  "/usr/local/go/bin"
  # Mac paths
  "/usr/local/MacGPG2/bin"
  "$HOME/Library/Python/3.8/bin"
  "/Library/Frameworks/Python.framework/Versions/3.8/bin"
  # Unix paths
  "/usr/local/bin"
  "/snap/bin"
  "/usr/sbin"
  "/usr/bin"
  "/sbin"
  "/bin"
)
export PATH=""
for p in $paths; do
  if test -d $p; then
    print_debug "path" "$p"
    if test -z $PATH; then
      export PATH="$p"
    else
      export PATH="$PATH:$p"
    fi
  fi
done

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768'
export HISTFILESIZE="$HISTSIZE"
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth'

# -----------------------------------------------------------------------------
# K8S exports -----------------------------------------------------------------
export K8S_DEFAULT_NAMESPACE='development'
export HELM_VALUES_PATH="$GFP/github.com/reynn/k8s/helm/values"

# -----------------------------------------------------------------------------
# GO exports ------------------------------------------------------------------
export GOPATH="$HOME/go"
export GO111MODULE='on'

# -----------------------------------------------------------------------------
# Git exports -----------------------------------------------------------------
# export GIT_CONFIG="$DFP/git/gitconfig"

# -----------------------------------------------------------------------------
# FZF exports -----------------------------------------------------------------

export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border"
export FZF_DEFAULT_COMMAND='fd -t f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# -----------------------------------------------------------------------------
# ZSH Exports -----------------------------------------------------------------
export UPDATE_ZSH_DAYS=3
