#!/usr/bin/env fish

set func_name "github.release.download"

complete -c $func_name -l default -d 'Create a default environment with some helpful tools'
complete -c $func_name -l delete -d 'Delete a release either all or just a specific version'
complete -c $func_name -l update-all -d 'Run an update for all tools in the environment file'
complete -c $func_name -s A -l add-to-env -d 'When installing this will persist the install for upgrading later'
complete -c $func_name -s a -l alias -d 'How to call the release after downloaded if different from the repo name'
complete -c $func_name -s d -l base-dir -d 'Where to store the data for this script)'
complete -c $func_name -s e -l env -d 'Set path if necessary'
complete -c $func_name -s E -l env-file -d 'The file to add tools to'
complete -c $func_name -s f -l filter -d 'Filter for the name of the binary if not found automatically'
complete -c $func_name -s p -l pattern -d 'File pattern for downloading from release asset list' -x
complete -c $func_name -s P -l pre-release -d 'Allow pre-releases to be pulled as well as stable'
complete -c $func_name -s r -l repo -d 'The name of the repo to get release from [repo-owner/repo-name]' -x
complete -c $func_name -s s -l show -d 'Show list of versions for the repo'
complete -c $func_name -s S -l show-assets -d 'Shows assets for a specific version"'

complete -c $func_name -s v -l verbose -d "Enable debug logging"
complete -c $func_name -s h -l help -d "print usage help"
complete -c $func_name -s q -l quiet -d "quiet all logged output"
