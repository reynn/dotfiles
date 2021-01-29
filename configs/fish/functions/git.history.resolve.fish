#!/usr/bin/env fish

function git.history.resolve -d 'Resolve the rest of git history after an initial shallow clone'
    function ___usage
        set -l help_args -a 'Resolve the rest of git history after an initial shallow clone'
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
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

    log.info 'Converting shallow clone to full clone'
    git fetch --unshallow
    log.info 'Updating remote config to access all branches'
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    git fetch origin
end
