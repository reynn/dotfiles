#!/usr/bin/env fish

function git.repos.clone -d "Clone repository to the layout used"
    ###########################################################
    # Variables
    ###########################################################
    set -x base_directory "$HOME/git"
    set -x git_host 'github.com'
    set -x protocol ssh
    set -x repos
    set -x cd_into

    function ___usage
        set -l help_args -a "Clone repository to the layout used [format:'$base_directory/$git_host/{owner}/{repo}']"
        set -a help_args -f 'r|repos|The owner/name of the repository to clone'
        set -a help_args -f "b|base-dir|The base directory to store repositories|$base_directory"
        set -a help_args -f "p|protocol|Clone protocol, either HTTPS or SSH|$protocol"
        set -a help_args -f "H|host|GitHub host name, for using against enterprise GitHub|$git_host"
        set -a help_args -f "c|cd|`cd` into the directory after clone|$cd_into"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case _
                set -a repos "$value"
                # Common args
            case b base-dir
                set base_directory $value
            case c cd
                set cd_into true
            case H host
                set -x git_host "$value"
            case p protocol
                set -x protocol (string lower $value)
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

    function __git_clone_repo
        set repo $argv

        log.debug "git_host : $git_host"
        log.debug "repo     : $repo"
        log.debug "protocol : $protocol"
        test (string lower "$protocol") = ssh; and set -x git_url "git@$git_host:$repo"; or set -x git_url "https://$git_host/$repo"
        log.debug "git_url  : $git_url"

        git clone --depth 1 "$git_url" "$base_directory/$git_host/$repo"

        if test "$cd_into" = true
            cd "$base_directory/$git_host/$repo"
        end
    end

    ###########################################################
    # Main logic
    ###########################################################
    for repo in $repos
        __git_clone_repo "$repo"
    end
end
