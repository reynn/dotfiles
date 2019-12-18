#!/bin/usr/env zsh

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$GFP/github.com/junegunn/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$GFP/github.com/junegunn/fzf/shell/key-bindings.zsh"

# -----------------------------------------------------------------------------
# FZF exports -----------------------------------------------------------------
# -----------------------------------------------------------------------------

export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border"
export FZF_DEFAULT_COMMAND='fd -t f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
