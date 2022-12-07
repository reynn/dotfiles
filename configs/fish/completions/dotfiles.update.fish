#!/usr/bin/env fish

# --- dotfiles.update ---

complete -c 'dotfiles.update' -d 'Add an update to run' -l 'add-update' -s 'a'
complete -c 'dotfiles.update' -d 'Run all available updates' -l 'all-updates' -s 'A'
complete -c 'dotfiles.update' -d 'Prepend an update to run' -l 'prepend-update' -s 'p'
complete -c 'dotfiles.update' -d 'Remove updates to run' -l 'reset-updates' -s 'R'
