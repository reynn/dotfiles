#!/usr/bin/env fish

## #######################################################################
## Examples
## #######################################################################
## `git.clean`
## #######################################################################

function git.clean -d 'Hard Reset of git changes as well as a clean of non tracked files'
    set -l to_clean (git clean -nx 2>/dev/null)

    function ___usage
        set -l help_args '-a' "Hard Reset of git changes as well as a clean of non tracked files [to_clean: '$to_clean']"
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

    git reset --hard

    if test (count $to_clean) -gt 0
        log.info -m "Cleaning these files"
        for tc in $to_clean
            log.info -l 'cleaner' -m $tc
        end
        # `-x` include cleaning of ignored files | `-f` force
        git clean -fx
    end
end
