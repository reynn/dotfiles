#!/usr/bin/env fish

function github.clone.repo -d "Clone repository to the layout used"
    # This is my preference on how to store cloned repositories.
    # Your preferences may be different if so feel free to adjust in a fork,
    # if you think it would benefit everyone by making this flexible while
    # not breaking functionality I am open to a PR
    ###########################################################
    # Variables
    ###########################################################
    set -lx base_directory "$HOME/git"
    set -lx git_host 'github.com'
    set -lx repo ''
    set -lx repo_name ''
    set -lx repo_owner ''

    function ___usage
        set -l help_args '-a' "Clone repository to the layout used [format:'$base_directory/$git_host/{owner}/{repo}']"
        set -a help_args '-f' 'r|repo|The owner/name of the repository to clone'
        set -a help_args '-f' "H|host|GitHub host name, for using against enterprise GitHub|$git_host"

        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case H host
                set git_host $value
            case r repo
                set repo $value
                set repo_owner (string split '/' $value | head -1)
                set repo_name (string split '/' $value | tail -1)
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
    end

    log.debug -m "git_host : $git_host"
    log.debug -m "repo     : $repo"
    log.debug -m "name     : $repo_name"
    log.debug -m "owner    : $repo_owner"

    ###########################################################
    # Main logic
    ###########################################################
    env GH_HOST=$git_host gh repo clone "$repo" "$base_directory/$git_host/$repo" -- --depth 1
end
