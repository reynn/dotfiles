#!/usr/bin/env fish

# --- artifactory.build.upload ---

complete -c 'artifactory.build.upload' -d 'Run the command without uploading files' -l 'dry-run' -s 'd'
complete -c 'artifactory.build.upload' -d 'Files in subdirectories are uploaded to the base subfolder' -l 'flat' -s 'f'
complete -c 'artifactory.build.upload' -d 'The Artifactory repository to upload to' -l 'repo' -s 'r'
complete -c 'artifactory.build.upload' -d 'Name of the Build that will be published' -l 'build-name' -s 'n'
complete -c 'artifactory.build.upload' -d 'A unique number for the build' -l 'build-number' -s 'N'
complete -c 'artifactory.build.upload' -d 'An ant style pattern to match files' -l 'glob' -s 'g'
complete -c 'artifactory.build.upload' -d 'Create a subfolder in the target repo' -l 'subfolder' -s 's'
