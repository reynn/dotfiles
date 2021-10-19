#!/usr/bin/fish

# --- vim.lunar ---
complete -c 'vim.lunar' -d 'Run through all setup options in proper order' -l 'setup-all' -s 'a' -x
complete -c 'vim.lunar' -d 'Clean all directories (complete uninstall)' -l 'clean-all' -s 'A' -x
complete -c 'vim.lunar' -d 'Clean all existing LunarVim installation files' -l 'clean-lunarvim' -s 'l'
complete -c 'vim.lunar' -d 'Complete setup for the LunarVim configuration' -l 'configure-lunarvim' -s 'L'
