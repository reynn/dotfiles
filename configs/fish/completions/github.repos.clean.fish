#!/usr/bin/env fish

# --- github.repos.clean ---

complete -c 'github.repos.clean' -d 'Owner of the repositories, will be used to filter forks' -l 'owner' -s 'o'
complete -c 'github.repos.clean' -d 'Dont actually delete the fork' -l 'noop' -s 'n'
