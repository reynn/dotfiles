# -----------------------------------------------------------------------------
# FZF Bindings ----------------------------------------------------------------
bindkey "^s" fzf-ssh
bindkey "^l" fzf-dps
bindkey "^k^l" fzf-k8s-logs
bindkey "^k^p" fzf-k8s-port-forward
bindkey "^f" fzf-funcs

# -----------------------------------------------------------------------------
# UNIX Bindings ---------------------------------------------------------------
# Use Ctrl-x,Ctrl-l to get the output of the last command
zmodload -i zsh/parameter
insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey "^X^L" insert-last-command-output
