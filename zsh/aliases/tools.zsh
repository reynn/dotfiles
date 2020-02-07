#!/usr/bin/env zsh

# -----------------------------------------------------------------------------
# Tool aliases ----------------------------------------------------------------
# -----------------------------------------------------------------------------

alias bfg='java -jar $BINS_DIR/bfg.jar'
alias tock="tock -cms -C 1 -f 'Day %j of %Y -- (%Y.%m.%d)'"
alias sterns='stern'
alias stern='stern -E linkerd-proxy'
alias vim='nvim'
alias pip='pip3'
alias cat='bat'
alias antibody_fix_perms='compaudit | xargs chmod g-w,o-w'
alias antibody_purge_bundles='antibody list | awk \"{print $1}\" | xargs -n1 antibody purge'
