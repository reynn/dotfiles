#!/usr/bin/fish

# --- permissions.change ---

complete -c 'permissions.change' -d 'Set the permissions for the given patterns using `chmod`' -l 'set-permissions' -s 'p'
complete -c 'permissions.change' -d 'The permissions to set using `chmod`' -l 'permissions' -s 'P'
complete -c 'permissions.change' -d 'Set the owner for the given patterns using `chown`' -l 'set-owner' -s 'o'
complete -c 'permissions.change' -d 'The owner to set using `chown`' -l 'owner' -s 'O'
