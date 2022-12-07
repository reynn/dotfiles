#!/usr/bin/env fish

# --- docker.images.list ---

complete -c 'docker.images.list' -d 'Clear the current list of columns' -l 'clear-columns'
complete -c 'docker.images.list' -d 'Prepend a column to the output' -l 'prepend-column' -s 'C'
complete -c 'docker.images.list' -d 'Add a column to the output' -l 'add-column' -s 'c'
