#!/usr/bin/env fish

complete -c github.release.download -l delete  -d 'Delete a release either all or just a specific version'
complete -c github.release.download -s e -l env -d 'Set path if necessary'
complete -c github.release.download -x -s r -l repo -d 'The name of the repo to get release from [repo-owner/repo-name]'
complete -c github.release.download -s p -l pattern -d 'File pattern for downloading from release asset list'
complete -c github.release.download -s a -l alias -d 'How to call the release after downloaded if different from the repo name'
complete -c github.release.download -s d -l base-dir -d 'Where to store the data for this script)'
complete -c github.release.download -s f -l filter -d 'Filter for the name of the binary if not found automatically'
complete -c github.release.download -s P -l pre-release -d 'Allow pre-releases to be pulled as well as stable'
complete -c github.release.download -s s -l show -d 'Show list of versions for the repo'
complete -c github.release.download -s S -l show-assets -d 'Shows assets for a specific version"'

complete -c aws.okta.auth -s v -l verbose -d "Enable debug logging"
complete -c aws.okta.auth -s h -l help -d "print usage help"
complete -c aws.okta.auth -s q -l quiet -d "quiet all logged output"
