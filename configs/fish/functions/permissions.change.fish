#!/usr/bin/env fish

function permissions.change -d "Update file permissions and ownership"
    set -x patterns
    set -x permissions 'u=rwx,g=rw,o=rw'
    set -x owner (id -u):(id -g)
    set -x set_permissions true
    set -x set_owner false
    set -x DEBUG true

    function ___usage
        set -l help_args -a 'Update file permissions and ownership'

        set -a help_args -f "p|set-permissions|Set the permissions for the given patterns using `chmod`|$set_permissions"
        set -a help_args -f "P|permissions|The permissions to set using `chmod`|$permissions"
        set -a help_args -f "o|set-owner|Set the owner for the given patterns using `chown`|$set_owner"
        set -a help_args -f "O|owner|The owner to set using `chown`|`(id -u):(id -g)`"

        set -a help_args -e ' -P 0777'
        set -a help_args -e ' -P "u=rwx,g=rw,o=r"'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case _
                while read -l pattern
                    set -a patterns "$pattern"
                end
            case p set-permissions
                set set_permissions false
            case P permissions
                set permissions "$value"
            case o set-owner
                set set_owner true
            case O owner
                set owner "$value"
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

    log debug "argv            : $argv"
    log debug "patterns        : $patterns"
    log debug "set_permissions : $set_permissions"
    log debug "permissions     : $permissions"
    log debug "set_owner       : $set_owner"
    log debug "owner           : $owner"

    for pattern in $patterns
        log "Updating permissions for $pattern"
        if test "$set_permissions" = true
            # chmod -R $permissions "$pattern"
        end
        if test "$set_owner" = true
            # chown -R $owner "$pattern"
        end
    end
end
