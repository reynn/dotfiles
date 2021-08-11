#!/usr/bin/fish

# --- media.archive ---

complete -c 'media.archive' -d 'Where media files will be moved to for archiving' -l 'backup-directory' -s 'b'
complete -c 'media.archive' -d 'Where media files will be from during archiving' -l 'source_directory' -s 's'
complete -c 'media.archive' -d 'Include an additional extension to the list' -l 'extension' -s 'e'
complete -c 'media.archive' -d 'Clear the list of extensions to add a limitted set only' -l 'clear-extensions' -s 'E'
complete -c 'media.archive' -d 'Maximum depth to iterate through' -l 'depth' -s 'd'
