#!/usr/bin/fish

# --- artifactory.build.download ---

complete -c 'artifactory.build.download' -d 'Dont complete the download just test what would happen' -l 'dry-run' -s 'd'
complete -c 'artifactory.build.download' -d 'Downloads subdirectories directly into the target directory' -l 'flat' -s 'f'
complete -c 'artifactory.build.download' -d 'The Artifactory repository to search for files' -l 'repo' -s 'r'
complete -c 'artifactory.build.download' -d 'The target folder to download files to' -l 'target' -s 't'
complete -c 'artifactory.build.download' -d 'An ant style pattern to match files' -l 'glob' -s 'g'
