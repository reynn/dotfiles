#!/usr/bin/fish

# --- nvim.update ---

complete -c 'nvim.update' -d 'Perform all actions (Clean update)' -l 'all' -s 'A'
complete -c 'nvim.update' -d 'Clean NVIM related files' -l 'clean-nvim' -s 'N'
complete -c 'nvim.update' -d 'Clean all cache files' -l 'clean-cache' -s 'C'
complete -c 'nvim.update' -d 'Ensure NVIM is configured' -l 'configure-nvim' -s 'n'
