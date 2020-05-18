#!/usr/bin/env zsh

#+============================================================================+
# Python
#+============================================================================+

#+============================================================================+
# Python: Pip
#+============================================================================+

alias pip='python3 -m pip'
alias 'pip install'='pip install --user'
alias pip_update_all='pip list --not-required --format json | jq -r ".[].name" | xargs -L 0 pip3 install --upgrade'
