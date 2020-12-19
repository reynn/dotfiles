#!/usr/bin/env fish

function dotfiles.update -d 'Run various updates to our system'
    set -lx available_updates 'ansible' 'env'
    set -lx default_updates 'ansible' 'env'
    set -lx updates_to_run

    function ___usage
        set -l help_args '-a' 'Run various updates to our system'
        set -a help_args '-f' "a|add-update|Add an update to run|"
        set -a help_args '-f' "A|all-updates|Runn all available updates|$default_updates"
        set -a help_args '-f' "p|prepend-update|Prepend an update to run|"
        set -a help_args '-f' 'R|reset-updates|Remove updates to run|false'

        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case A 'all-updates'
                set updates_to_run $default_updates
            case a 'add-update'
                set -a updates_to_run "$value"
            case p 'prepend-update'
                set -p updates_to_run "$value"
            case R 'reset-updates'
                set -e updates_to_run
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
    end

    for update in $updates_to_run
        if not contains -- "$update" $available_updates
            log.error -m "[$update] is not available."
            continue
        end
        switch $update
            case env
                log.info -m 'Updating environment'
                dotfiles.env.update
            case ansible
                log.info -m 'Running ansible playbook'
                dotfiles.ansible.update
            case *
                log.error -m "$update is not available"
        end
    end
end
