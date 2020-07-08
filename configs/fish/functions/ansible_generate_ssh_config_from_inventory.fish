function ansible_generate_ssh_config_from_inventory -d "Generate valid SSH config from an Ansible inventory"
    set -l INVENTORY_FILE "$1"
    set -l CONFIG_DIRECTORY "$HOME/.ssh/config.d"
    set -l ENTRIES (ansible-inventory -i $INVENTORY_FILE --list | jq -c '._meta.hostvars | to_entries[] | {"name": .key, "ip": .value.ansible_host, "user": .value.ansible_user, "ident": .value.ansible_private_key_file}')

    mkdir -p $CONFIG_DIRECTORY

    for entry in $ENTRIES
        if string match -q -- "*windows*" $entry
            set -l name (echo $entry | jq -r '.name')
            set -l splitName (helpers text split -d '_' "$name")
            set -l dc $splitName[1]
            set -l ip (echo $entry | jq -r '.ip')
            set -l user (echo $entry | jq -r '.user')
            set -l identFile (echo $entry | jq -r '.ident')
            echo "name      [$name]"
            echo "splitName [$splitName]"
            echo "dc        [$dc]"
            echo "ip        [$ip]"
            echo "user      [$user]"
            echo "identFile [$identFile]"

            echo "HOST: $name@$ip"
            # echo "Host $name" >>$CONFIG_DIRECTORY/$dc
            # echo "  HostName $ip" >>$CONFIG_DIRECTORY/$dc
            # if test "$identFile" != "null"
            #     echo "  IdentityFile $identFile" >>$CONFIG_DIRECTORY/$dc
            # end
            # if test "$user" != "null"
            #     echo "  User $user" >>$CONFIG_DIRECTORY/$dc
            # end
            # echo "" >>$CONFIG_DIRECTORY/$dc
        end
    end
end
