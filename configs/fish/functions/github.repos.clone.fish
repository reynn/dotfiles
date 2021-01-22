#!/usr/bin/env fish

function github.repos.clone -d "Clone repository to the layout used"
    ###########################################################
    # Variables
    ###########################################################
    set -x base_directory "$HOME/git"
    set -x git_host 'github.com'
    set -x repos

    function ___usage
        set -l help_args -a "Clone repository to the layout used [format:'$base_directory/$git_host/{owner}/{repo}']"
        set -a help_args -f 'r|repos|The owner/name of the repository to clone'
        set -a help_args -f "b|base-dir|The base directory to store repositories|$HOME/git"
        set -a help_args -f "H|host|GitHub host name, for using against enterprise GitHub|$git_host"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case _
                set -a repos "$value"
                # Common args
            case b base-dir
                set base_directory $value
            case H host
                set -x git_host "$value"
            case r repos
                set -x repos "$value"
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

    function __github_clone_repo
        set repo $argv

        log.debug "git_host : $git_host"
        log.debug "repo     : $repo"

        env GH_HOST=$git_host gh repo clone "$repo" "$base_directory/$git_host/$repo" -- --depth 1
    end

    ###########################################################
    # Main logic
    ###########################################################
    for repo in $repos
        __github_clone_repo "$repo"
    end
end
