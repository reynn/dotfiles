#!/usr/bin/env fish


complete -c github.download.release -x -s 'r' -l repo     -d 'The name of the repo to get release from [repo-owner/repo-name]'
complete -c github.download.release -s 'e' -l env         -d 'Set path if necessary'
complete -c github.download.release -s 'c' -l clean       -d 'Removes assets after extracting'
complete -c github.download.release -s 'p' -l pattern     -d 'File pattern for downloading from release asset list'
complete -c github.download.release -s 'a' -l alias       -d 'How to call the release after downloaded if different from the repo name'
complete -c github.download.release -s 'd' -l base-dir    -d 'Where to store the data for this script), default(\$HOME/.bins'
complete -c github.download.release -s 'f' -l filter      -d 'Filter for the name of the binary if not found automatically'
complete -c github.download.release -s 'P' -l pre-release -d 'Allow pre-releases to be pulled as well as stable'
complete -c github.download.release -s 's' -l show        -d 'Show list of versions for the repo'
complete -c github.download.release -s 'S' -l show-assets -d "After selecting a version show the assets available to download"
complete -c github.download.release -s 'h' -l help        -d "print usage help"
