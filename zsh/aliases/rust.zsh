#!/usr/bin/env zsh

# -----------------------------------------------------------------------------
## Cargo aliases --------------------------------------------------------------

alias cargo_update_all='cargo install --list | grep -v ":" | xargs cargo install --force'
