complete -c vers -n "__fish_use_subcommand" -s d -l data-dir -d 'Where to store the data application data' -r -f -a "(__fish_complete_directories)"
complete -c vers -n "__fish_use_subcommand" -s e -l env -d 'Environment where the tool will be installed to' -r
complete -c vers -n "__fish_use_subcommand" -l github-api-token -d 'A GitHub API token to use authenticated requests to the API' -r
complete -c vers -n "__fish_use_subcommand" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_use_subcommand" -s V -l version -d 'Print version information'
complete -c vers -n "__fish_use_subcommand" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_use_subcommand" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_use_subcommand" -s l -l local -d 'Use a local environment'
complete -c vers -n "__fish_use_subcommand" -f -a "add" -d 'Add a tool to the designated environment'
complete -c vers -n "__fish_use_subcommand" -f -a "remove" -d 'Remove a tool from the designated environment'
complete -c vers -n "__fish_use_subcommand" -f -a "list" -d 'List tools available in the designated environment'
complete -c vers -n "__fish_use_subcommand" -f -a "sync" -d 'sync all version information with listed in the env config file'
complete -c vers -n "__fish_use_subcommand" -f -a "update" -d 'Update tools to the latest version available from GitHub'
complete -c vers -n "__fish_use_subcommand" -f -a "completions" -d 'Generate shell completions for Vers to enable tab completions'
complete -c vers -n "__fish_use_subcommand" -f -a "env" -d 'show the exports required for setup'
complete -c vers -n "__fish_use_subcommand" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c vers -n "__fish_seen_subcommand_from add" -s A -l alias -d 'Alias to use instead of the repository name' -r
complete -c vers -n "__fish_seen_subcommand_from add" -s a -l asset-pattern -d 'Pattern used to determine which file from the release to download' -r
complete -c vers -n "__fish_seen_subcommand_from add" -s f -l file-filter -d 'Filter used to find the executable to link into the environment' -r
complete -c vers -n "__fish_seen_subcommand_from add" -s P -l pre-release -d 'Allow install of pre-release versions of the tool'
complete -c vers -n "__fish_seen_subcommand_from add" -s S -l show -d 'Show available versions'
complete -c vers -n "__fish_seen_subcommand_from add" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from add" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from add" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from remove" -s a -l all -d 'Remove all versions of a tool. Default is to delete the version used by the environment only'
complete -c vers -n "__fish_seen_subcommand_from remove" -s l -l link-only -d 'Removes the symlink only while leaving the downloaded assets in tact for reuse later'
complete -c vers -n "__fish_seen_subcommand_from remove" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from remove" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from remove" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from list" -s o -l output -d 'Control how the list is output to the console' -r -f -a "{table	,text	,json	}"
complete -c vers -n "__fish_seen_subcommand_from list" -s i -l installed -d 'List all installed versions of tools available to the environment instead of just the currently used one'
complete -c vers -n "__fish_seen_subcommand_from list" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from list" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from list" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from sync" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from sync" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from sync" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from update" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from update" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from update" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from completions" -s s -l shell -d 'the shell to generate completions for' -r -f -a "{bash	,elvish	,fish	,powershell	,zsh	}"
complete -c vers -n "__fish_seen_subcommand_from completions" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from completions" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from completions" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from env" -s n -l name -d 'Name of the environment' -r
complete -c vers -n "__fish_seen_subcommand_from env" -s s -l shell -d 'Prints out a command to set the environment path in the shells environment' -r
complete -c vers -n "__fish_seen_subcommand_from env" -s b -l bare-path -d 'Output just the bath to the environment rather than a setup string'
complete -c vers -n "__fish_seen_subcommand_from env" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from env" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from env" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from help" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from help" -s q -l quiet -d 'Less output per occurrence'