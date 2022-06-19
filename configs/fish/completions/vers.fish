complete -c vers -n "__fish_use_subcommand" -s e -l env -d 'Environment where the tool will be installed to' -r
complete -c vers -n "__fish_use_subcommand" -l github-api-token -d 'A GitHub API token to use authenticated requests to the API' -r
complete -c vers -n "__fish_use_subcommand" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_use_subcommand" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_use_subcommand" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_use_subcommand" -s l -l local -d 'Use a local environment'
complete -c vers -n "__fish_use_subcommand" -f -a "add" -d 'Add a tool to the designated environment'
complete -c vers -n "__fish_use_subcommand" -f -a "remove" -d 'Remove a tool from the designated environment'
complete -c vers -n "__fish_use_subcommand" -f -a "list" -d 'List tools available in the designated environment'
complete -c vers -n "__fish_use_subcommand" -f -a "sync" -d 'sync all version information with listed in the env config file'
complete -c vers -n "__fish_use_subcommand" -f -a "update" -d 'Update tools to the latest version'
complete -c vers -n "__fish_use_subcommand" -f -a "env" -d 'show the exports required for setup'
complete -c vers -n "__fish_use_subcommand" -f -a "completions"
complete -c vers -n "__fish_use_subcommand" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c vers -n "__fish_seen_subcommand_from add" -s a -l alias -d 'Alias to use instead of the repository name' -r
complete -c vers -n "__fish_seen_subcommand_from add" -s p -l pattern -d 'Pattern used to determine which file from the release to download' -r
complete -c vers -n "__fish_seen_subcommand_from add" -s f -l filter -d 'Filter used to find the executable to link into the environment' -r
complete -c vers -n "__fish_seen_subcommand_from add" -s P -l pre-release -d 'Allow install of pre-release versions of the tool'
complete -c vers -n "__fish_seen_subcommand_from add" -s S -l show -d 'Show available versions'
complete -c vers -n "__fish_seen_subcommand_from add" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from add" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from add" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from remove" -s a -l all -d 'Remove all versions of a tool. Default is to delete the currently installed version'
complete -c vers -n "__fish_seen_subcommand_from remove" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from remove" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from remove" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from list" -s i -l installed
complete -c vers -n "__fish_seen_subcommand_from list" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from list" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from list" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from sync" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from sync" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from sync" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from update" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from update" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from update" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from env" -s n -l name -r
complete -c vers -n "__fish_seen_subcommand_from env" -s s -l shell -r
complete -c vers -n "__fish_seen_subcommand_from env" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from env" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from env" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from completions" -s s -l shell -r -f -a "{bash	,elvish	,fish	,powershell	,zsh	}"
complete -c vers -n "__fish_seen_subcommand_from completions" -s h -l help -d 'Print help information'
complete -c vers -n "__fish_seen_subcommand_from completions" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from completions" -s q -l quiet -d 'Less output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from help" -s v -l verbose -d 'More output per occurrence'
complete -c vers -n "__fish_seen_subcommand_from help" -s q -l quiet -d 'Less output per occurrence'
