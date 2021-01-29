#!/usr/bin/env fish

function command.is_available -d 'Determines if a command is available to execute'
    set -x utils_command

    function ___usage -d 'Determines if a command is available to execute'
        set -l help_args -a "Determines if a command is available to execute"
        set -a help_args -f 'c|cmd|The command to validate|'
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case c cmd
                set utils_command "$value"
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
        end
    end

    set -l command_directory (command -v "$utils_command")
    log.debug "Checking for command  : $utils_command"
    log.debug "Command path          : $command_directory"
    if test -e "$command_directory"
        return 0
    else
        return 1
    end
end
