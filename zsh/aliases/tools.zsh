#!/usr/bin/env zsh

# -----------------------------------------------------------------------------
# Tool aliases ----------------------------------------------------------------

alias bfg='java -jar $BINS_DIR/bfg.jar'
alias vim='nvim'
alias xargs='xargs -I"{}"'

# -----------------------------------------------------------------------------
# Antibody (zsh package manager) ----------------------------------------------

alias antibody_fix_perms='compaudit | xargs chmod g-w,o-w'
alias antibody_purge_bundles="antibody list | awk '{print \$1}' | xargs -n1 antibody purge"
