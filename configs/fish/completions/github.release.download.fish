#!/usr/bin/fish

# --- github.release.download ---

complete -c 'github.release.download' -d 'Create a default environment with some helpful tools' -l 'defaults'
complete -c 'github.release.download' -d 'When installing this will persist the install for upgrading later' -l 'add-to-env' -s 'A'
complete -c 'github.release.download' -d 'How to call the release after downloaded if different from the repo name' -l 'alias' -s 'a'
complete -c 'github.release.download' -d 'Removes the downloaded assets after extracting' -l 'clean' -s 'c'
complete -c 'github.release.download' -d 'Where to store the data for this script' -l 'base-dir' -s 'd'
complete -c 'github.release.download' -d 'Delete a release either all or just a specific version' -l 'delete' -s 'D'
complete -c 'github.release.download' -d 'The file to add tools to' -l 'env-file' -s 'E'
complete -c 'github.release.download' -d 'Set path if necessary' -l 'env' -s 'e'
complete -c 'github.release.download' -d 'Filter for the name of the binary if not found automatically' -l 'filter' -s 'f'
complete -c 'github.release.download' -d 'File pattern for downloading from release asset list' -l 'pattern' -s 'p'
complete -c 'github.release.download' -d 'Allow pre-releases to be pulled as well as stable' -l 'pre-release' -s 'P'
complete -c 'github.release.download' -d 'The name of the repo to get release from [repo-owner/repo-name]' -l 'repo' -s 'r'
complete -c 'github.release.download' -d 'Shows assets for a specific version' -l 'show-assets' -s 'S'
complete -c 'github.release.download' -d 'Show list of versions for the repo' -l 'show' -s 's'
complete -c 'github.release.download' -d 'Run an update for all tools in the environment file' -l 'update-all' -s 'U'
