#!/bin/usr/env zsh

# -----------------------------------------------------------------------------
# XDG Config ------------------------------------------------------------------
# -----------------------------------------------------------------------------

export XDG_BASE_PATH="$HOME/.xdg"
export XDG_CACHE_HOME="$XDG_BASE_PATH/cache"
export XDG_CONFIG_HOME="$XDG_BASE_PATH/config"
export XDG_DATA_HOME="$XDG_BASE_PATH/data"

# -----------------------------------------------------------------------------
# Basic Unix ------------------------------------------------------------------
# -----------------------------------------------------------------------------

export UPDATE_ZSH_DAYS='3'
export SSH_KEY_PATH='~/.ssh/rsa_id'
export EDITOR='nvim'
export PYENV_ROOT=`pyenv root`

export POSSIBLE_PATHS=(
  "$PYENV_ROOT/bin"
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
  # "$HOME/Library/Python/3.8/bin"
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
for p in $POSSIBLE_PATHS; do
  # Test if the directory exists
  if test -d $p; then
    # Test if the existing PATH variable is set to anything
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
# GO exports ------------------------------------------------------------------
export GOPATH="$HOME/go"
export GO111MODULE='on'

