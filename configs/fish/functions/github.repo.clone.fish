#!/usr/bin/env fish

function github.repo.clone -d "Clone repository to the layout used"
    # This is my preference on how to store cloned repositories.
    # Your preferences may be different if so feel free to adjust in a fork,
    # if you think it would benefit everyone by making this flexible while
    # not breaking functionality I am open to a PR
    ###########################################################
    # Variables
    ###########################################################
    set -x base_directory "$HOME/git"
    set -x git_host 'github.com'
    set -x repo ''
    set -x repo_name ''
    set -x repo_owner ''

    function ___usage
        set -l help_args '-a' "Clone repository to the layout used [format:'$base_directory/$git_host/{owner}/{repo}']"
        set -a help_args '-f' 'r|repo|The owner/name of the repository to clone'
        set -a help_args '-f' "H|host|GitHub host name, for using against enterprise GitHub|$git_host"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case H host
                set -x git_host "$value"
            case r repo
                set -x repo "$value"
                set -x repo_owner (string split '/' "$value" | head -1)
                set -x repo_name (string split '/' "$value" | tail -1)
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET 'true'
            case v verbose
                set -x DEBUG 'true'
        end
    end

    log.debug "git_host : $git_host"
    log.debug "repo     : $repo"
    log.debug "name     : $repo_name"
    log.debug "owner    : $repo_owner"

    ###########################################################
    # Main logic
    ###########################################################
    env GH_HOST=$git_host gh repo clone "$repo" "$base_directory/$git_host/$repo" -- --depth 1
end
