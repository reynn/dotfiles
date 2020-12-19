#!/usr/bin/env fish

function github.clean.forks -d "Delete forks from GitHub"
    ###########################################################
    # Variables
    ###########################################################
    set -lx owner "$USER"
    set -lx noop 'false'

    function ___usage
        set -l help_args '-a' 'Delete all repositories from GitHub that are forked by the specified user'
        set -a help_args '-f' "o|owner|Owner of the repositories, will be used to filter forks|$owner"
        set -a help_args '-f' "n|noop|Dont actually delete the fork|$noop"
        set -a help_args '-c' '1|Noop exit'

        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case o owner
                set owner (string trim $value)
            case n noop
                set noop 'true'
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
    end

    log.info -l 'args.owner' -m "($owner)"

    ###########################################################
    # Main logic
    ###########################################################
    set -l forked_repos (gh api users/$owner/repos --paginate | jq -r '.[] | select(.fork==true) | .full_name')
    for forked_repo in $forked_repos
        if test "$noop" = 'false'
            gh api repos/$forked_repo --method DELETE
            log.info -l 'delete.repo' -m "Repo ($forked_repo) deleted"
        else
            log.info -l 'delete.repo.noop' -m "Repo ($forked_repo) deleted"
            return 1
        end
    end
end
