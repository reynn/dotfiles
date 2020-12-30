Verbose level: 0
complete -c versm -n "__fish_use_subcommand" -s c -l config-file -d 'Provide a path to a config file' -r
complete -c versm -n "__fish_use_subcommand" -s i -l iterations -d 'How many iterations to run through' -r
complete -c versm -n "__fish_use_subcommand" -s v -l verbose -d 'Increase output verbosity'
complete -c versm -n "__fish_use_subcommand" -s h -l help -d 'Prints help information'
complete -c versm -n "__fish_use_subcommand" -s V -l version -d 'Prints version information'
complete -c versm -n "__fish_use_subcommand" -f -a "install" -d 'Install new versions'
complete -c versm -n "__fish_use_subcommand" -f -a "update" -d 'Update versions and/or cache'
complete -c versm -n "__fish_use_subcommand" -f -a "list" -d 'List installed versions'
complete -c versm -n "__fish_use_subcommand" -f -a "remove" -d 'Remove an installed version'
complete -c versm -n "__fish_use_subcommand" -f -a "use" -d 'Switch version being used'
complete -c versm -n "__fish_use_subcommand" -f -a "completions" -d 'Generate completions for given shell'
complete -c versm -n "__fish_use_subcommand" -f -a "help" -d 'Prints this message or the help of the given subcommand(s)'
complete -c versm -n "__fish_seen_subcommand_from install" -s t -l manager-type -d 'The installation manager' -r -f -a "github"
complete -c versm -n "__fish_seen_subcommand_from install" -s r -l repo -d 'The repository to work with'
complete -c versm -n "__fish_seen_subcommand_from install" -s h -l help -d 'Prints help information'
complete -c versm -n "__fish_seen_subcommand_from install" -s V -l version -d 'Prints version information'
complete -c versm -n "__fish_seen_subcommand_from update" -s t -l manager-type -d 'The installation manager' -r -f -a "github"
complete -c versm -n "__fish_seen_subcommand_from update" -s h -l help -d 'Prints help information'
complete -c versm -n "__fish_seen_subcommand_from update" -s V -l version -d 'Prints version information'
complete -c versm -n "__fish_seen_subcommand_from list" -s t -l manager-type -d 'The installation manager' -r -f -a "github"
complete -c versm -n "__fish_seen_subcommand_from list" -s h -l help -d 'Prints help information'
complete -c versm -n "__fish_seen_subcommand_from list" -s V -l version -d 'Prints version information'
complete -c versm -n "__fish_seen_subcommand_from remove" -s t -l manager-type -d 'The installation manager' -r -f -a "github"
complete -c versm -n "__fish_seen_subcommand_from remove" -s h -l help -d 'Prints help information'
complete -c versm -n "__fish_seen_subcommand_from remove" -s V -l version -d 'Prints version information'
complete -c versm -n "__fish_seen_subcommand_from use" -s t -l manager-type -d 'The installation manager' -r -f -a "github"
complete -c versm -n "__fish_seen_subcommand_from use" -s h -l help -d 'Prints help information'
complete -c versm -n "__fish_seen_subcommand_from use" -s V -l version -d 'Prints version information'
complete -c versm -n "__fish_seen_subcommand_from completions" -s s -l shell -d 'The shell to generate completions for' -r -f -a "fish elvish zsh bash powershell"
complete -c versm -n "__fish_seen_subcommand_from completions" -s h -l help -d 'Prints help information'
complete -c versm -n "__fish_seen_subcommand_from completions" -s V -l version -d 'Prints version information'
complete -c versm -n "__fish_seen_subcommand_from help" -s h -l help -d 'Prints help information'
complete -c versm -n "__fish_seen_subcommand_from help" -s V -l version -d 'Prints version information'
