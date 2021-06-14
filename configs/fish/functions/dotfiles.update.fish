#!/usr/bin/env fish

function dotfiles.update -d 'Run various updates to our system'
    set -x available_updates ansible env system path fisher tide
    set -x default_updates fisher env path ansible
    set -x updates_to_run

    function ___usage
        set -l help_args -a 'Run various updates to our system'
        set -a help_args -f "a|add-update|Add an update to run|"
        set -a help_args -f "A|all-updates|Run all available updates|$default_updates"
        set -a help_args -f "p|prepend-update|Prepend an update to run|"
        set -a help_args -f 'R|reset-updates|Remove updates to run|false'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case A all-updates
                set updates_to_run $default_updates
            case a add-update
                set -a updates_to_run "$value"
            case p prepend-update
                set -p updates_to_run "$value"
            case R reset-updates
                set -e updates_to_run
            case v verbose
                set -x DEBUG true
            case h help
                ___usage
                return 0
        end
    end

    for update in $updates_to_run
        if not contains -- "$update" $available_updates
            log error "[$update] is not a recognized update"
            continue
        end

        if not functions -q dotfiles.$update.update
            log error "dotfiles.$update.update is not available"
            continue
        end
        log "Executing $update update"
        dotfiles.$update.update
    end
end
