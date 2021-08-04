#!/usr/bin/env fish
# TODO: Update to clean more than just forks
function github.repos.clean -d "Delete forks from GitHub"
    ###########################################################
    # Variables
    ###########################################################
    set -x owner "$USER"
    set -x noop false

    function ___usage
        set -l help_args -a 'Delete all repositories from GitHub that are forked by the specified user'

        set -a help_args -f "o|owner|Owner of the repositories, will be used to filter forks|$owner"
        set -a help_args -f "n|noop|Dont actually delete the fork|$noop"

        set -a help_args -c '1|Noop exit'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case o owner
                set owner (string trim "$value")
            case n noop
                set noop true
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

    __log "args.owner: ($owner)"

    # #######################
    # Main logic
    # #######################
    set forked_repos (gh api users/$owner/repos --paginate | dasel select --null -r json --plain -m '.(fork=true).full_name')

    for forked_repo in $forked_repos
        if test "$noop" = false
            gh api repos/$forked_repo --method DELETE
            __log "Repo ($forked_repo) deleted"
        else
            __log "Repo ($forked_repo) deleted -->NOOP<--"
        end
    end
end
