#!/usr/bin/env fish

function git.clone -d "Clone repository to the layout used"
    ###########################################################
    # Variables
    ###########################################################
    set -x base_directory "$HOME/git"
    set -x git_host 'github.com'
    set -x protocol ssh
    set -x repos
    set -x cd_into
    set -x recursive
    set -x full_checkout false

    function ___usage
        set -l help_args -a "Clone repository to the layout used [format:'$base_directory/$git_host/{owner}/{repo}']"
        set -a help_args -f "b|base-dir|The base directory to store repositories|$base_directory"
        set -a help_args -f "c|cd|`cd` into the directory after clone|$cd_into"
        set -a help_args -f "F|full-checkout|Does a complete checkout of the repo instead of shallow clone|$full_checkout"
        set -a help_args -f "H|host|GitHub host name, for using against enterprise GitHub|$git_host"
        set -a help_args -f "p|protocol|Clone protocol, either HTTPS or SSH|$protocol"
        set -a help_args -f 'r|repos|The owner/name of the repository to clone'
        set -a help_args -f "R|recursive|Recursive clone so submodules are initialized|$recursive"

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
            case F full-checkout
                set full_checkout "true"
            case H host
                set git_host "$value"
            case p protocol
                set protocol (string lower $value)
            case r repos
                set repos "$value"
            case R recursive
                set recursive "true"
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

        __log debug "git_host : $git_host"
        __log debug "repo     : $repo"
        __log debug "protocol : $protocol"
        test "$protocol" = "ssh"; and set -x git_url "git@$git_host:$repo"; or set -x git_url "https://$git_host/$repo"
        __log debug "git_url  : $git_url"
        set -l local_dir "$base_directory/$git_host/$repo"
        set -l git_clone_args clone
        test "$full_checkout" != "true"; and set -a git_clone_args "--depth" "1"
        test "$recursive" = "true"; and set -a git_clone_args "--recursive"
        set -a git_clone_args "$git_url"
        set -a git_clone_args "$local_dir"

        __log debug "git $git_clone_args"
        git $git_clone_args

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
