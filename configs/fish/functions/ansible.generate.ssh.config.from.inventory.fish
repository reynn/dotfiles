#!/usr/bin/env fish

function ansible.generate.ssh.config.from.inventory -d "Generate valid SSH config from an Ansible inventory"
    set -l INVENTORY_FILE "$argv[1]"
    set -l CONFIG_DIRECTORY "$HOME/.ssh/config.d"

    if test -z $INVENTORY_FILE
        log.info -m 'No inventory file provided'
        return 0
    end

    set -l ENTRIES (ansible-inventory -i $INVENTORY_FILE --list |\
      jq -c '._meta.hostvars | to_entries[] | {"name": .key, "ip": .value.ansible_host, "user": .value.ansible_user, "ident": .value.ansible_private_key_file}')

    if test -d "$CONFIG_DIRECTORY"
        log.debug -m "Cleaning SSH Config directory [$CONFIG_DIRECTORY]"
        # Only remove the files that start with a letter, to preserve any . prefixed files
        fd -tf '^[a-zA-Z].+' "$CONFIG_DIRECTORY" -X rm -f {} \;
    else
        mkdir -p $CONFIG_DIRECTORY
    end

    for entry in $ENTRIES
        if string match --quiet --invert -- "*windows*" $entry
            set -l name (echo $entry | jq -r '.name')
            set -l splitName (helpers text split -d '_' "$name")
            set -l dc $splitName[1]
            set -l ip (echo $entry | jq -r '.ip')
            set -l user (echo $entry | jq -r '.user')
            set -l identFile (echo $entry | jq -r '.ident')
            log.debug -l "name" -m "[$name]"
            log.debug -l "splitName" -m "[$splitName]"
            log.debug -l "dc" -m "[$dc]"
            log.debug -l "ip" -m "[$ip]"
            log.debug -l "user" -m "[$user]"
            log.debug -l "identFile" -m "[$identFile]"

            log.info -l "HOST" -m "[$name] ssh: $user@$ip"
            echo "Host $name" >>$CONFIG_DIRECTORY/$dc
            echo "  HostName $ip" >>$CONFIG_DIRECTORY/$dc
            if test "$identFile" != "null"
                echo "  IdentityFile $identFile" >>$CONFIG_DIRECTORY/$dc
            end
            if test "$user" != "null"
                echo "  User $user" >>$CONFIG_DIRECTORY/$dc
            end
            echo "" >>$CONFIG_DIRECTORY/$dc
        end
    end
end