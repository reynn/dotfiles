#!/usr/bin/env fish

function git.history.resolve -d 'Resolve the rest of git history after an initial shallow clone'
    function ___usage
        set -l help_args '-a' 'Resolve the rest of git history after an initial shallow clone'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
    end
    log.info -m 'Converting shallow clone to full clone'
    git fetch --unshallow
    log.info -m 'Updating remote config to access all branches'
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    git fetch origin
end
