#!/usr/bin/env fish
# TODO: Refactor to more easily handle multiple inventories

## #######################################################################
## Examples
## #######################################################################
## `ansible.generate.ssh.config.from.inventory $DFP/ansible/inventory.yaml` -> list all fonts piped to fzf for easier searching
## #######################################################################

function ansible.config.generate -d "Generate valid SSH config from an Ansible inventory"

    set -l INVENTORY_FILE "$argv[1]"
    set -l CONFIG_DIRECTORY "$HOME/.ssh/config.d"

    function ___usage
        set -l help_args -a 'Creates an SSH config from an Ansible inventory file'
        __dotfiles_help $help_args
    end

    if test "$argv[1]" = -h
        ___usage
        return 0
    end

    if not command.is_available -c ansible
        __log error '`ansible` is not installed'
        return 1
    end

    if test -z $INVENTORY_FILE
        __log 'No inventory file provided'
        return 0
    end

    set -l ENTRIES (ansible-inventory -i $INVENTORY_FILE --list |\
      jq -c '._meta.hostvars | to_entries[] | {"name": .key, "ip": .value.ansible_host, "user": .value.ansible_user, "ident": .value.ansible_private_key_file}')

    if test -d "$CONFIG_DIRECTORY"
        __log debug "Cleaning SSH Config directory [$CONFIG_DIRECTORY]"
        # Only remove the files that start with a letter, to preserve any . prefixed files
        fd -tf '^[a-zA-Z].+' "$CONFIG_DIRECTORY" -X rm -f {} \;
    else
        mkdir -p $CONFIG_DIRECTORY
    end

    for entry in $ENTRIES
        if string match --quiet --invert -- "*windows*" $entry
            set -l name (echo $entry | dasel select -r json '.name' --plain)
            set -l splitName (string split '_' "$name")
            set -l dc "$splitName[1]"
            set -l ip (echo $entry | dasel select -r json '.ip' --plain)
            set -l user (echo $entry | dasel select -r json '.user' --plain; or echo "centos")
            set -l identFile (echo $entry | dasel select -r json '.ident' --plain)
            __log debug "name       : [$name]"
            __log debug "splitName  : [$splitName]"
            __log debug "dc         : [$dc]"
            __log debug "ip         : [$ip]"
            __log debug "user       : [$user]"
            __log debug "identFile  : [$identFile]"

            __log "[$name] ssh: $user@$ip"
            echo "Host $name" >>$CONFIG_DIRECTORY/$dc
            echo "  HostName $ip" >>$CONFIG_DIRECTORY/$dc
            if test "$identFile" != null
                echo "  IdentityFile $identFile" >>$CONFIG_DIRECTORY/$dc
            end
            if test "$user" != null
                echo "  User $user" >>$CONFIG_DIRECTORY/$dc
            end
            echo "" >>$CONFIG_DIRECTORY/$dc
        end
    end
end
