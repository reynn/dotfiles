#!/usr/bin/env zsh

# -----------------------------------------------------------------------------
## Pip aliases ----------------------------------------------------------------

alias pip='pip3'
alias pip_update_all='pip list --not-required --format json | jq -r ".[].name" | xargs -L 0 pip3 install --upgrade'
