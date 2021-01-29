#!/usr/bin/env fish

## #######################################################################
## Examples
## #######################################################################
## `git.clean`
## #######################################################################

function git.changes.kill -d 'Hard Reset of git changes as well as a clean of non tracked files'
    set -l to_clean (git clean -nx 2>/dev/null)

    function ___usage
        set -l help_args -a "Hard Reset of git changes as well as a clean of non tracked files"
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

    git reset --hard

    if test (count $to_clean) -gt 0
        log.info "Cleaning these files"
        for tc in $to_clean
            log.info -l cleaner $tc
        end
        # `-x` include cleaning of ignored files | `-f` force
        git clean -fx
    end
end
