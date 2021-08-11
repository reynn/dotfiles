#!/usr/bin/fish

# --- dotfiles.ansible.update ---

complete -c 'dotfiles.ansible.update' -d 'help' -l 'h' -s 'h'
complete -c 'dotfiles.ansible.update' -d 'Add environment variables to the Ansible playbook command' -l 'env' -s 'e'
complete -c 'dotfiles.ansible.update' -d 'Tags to run instead of full playbook' -l 'tags' -s 't'
