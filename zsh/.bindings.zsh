FP="$DFP/zsh/.bindings.zsh"

# -----------------------------------------------------------------------------
#### File Aliases -------------------------------------------------------------
alias BE="vim $FP" # alias edit
alias BR="source $FP" # alias reload

# -----------------------------------------------------------------------------
# FZF Bindings ----------------------------------------------------------------
bindkey "^s" fzf-ssh
bindkey "^l" fzf-dps
bindkey "^k" fzf-kls
bindkey "^p" fzf-kspf

# -----------------------------------------------------------------------------
# UNIX Bindings ---------------------------------------------------------------
# Use Ctrl-x,Ctrl-l to get the output of the last command
zmodload -i zsh/parameter
insert-last-command-output() {
LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey "^X^L" insert-last-command-output
