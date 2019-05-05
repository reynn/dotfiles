# Setup fzf
# ---------
if [[ ! "$PATH" == *$GFP/junegunn/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$GFP/junegunn/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$GFP/junegunn/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$GFP/junegunn/fzf/shell/key-bindings.zsh"
