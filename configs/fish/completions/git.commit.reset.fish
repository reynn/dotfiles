#!/usr/bin/env fish

# --- git.commit.reset ---

complete -c 'git.commit.reset' -d 'Overwrite the default FZF preview command' -l 'preview' -s 'p'
complete -c 'git.commit.reset' -d 'Max number of commits to show in the FZF list' -l 'max-count' -s 'n'
complete -c 'git.commit.reset' -d 'Provide a SHA instead of using FZF to select one' -l 'sha' -s 's'
