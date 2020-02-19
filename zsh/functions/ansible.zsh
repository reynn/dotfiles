#!/usr/bin/env zsh

# -----------------------------------------------------------------------------
# Ansible functions -----------------------------------------------------------
# -----------------------------------------------------------------------------

function generate_ssh_config_from_ansible_inventory {
  local INVENTORY_FILE="$1"
  local CONFIG_DIRECTORY="${2:-$HOME/.ssh/configs}"
  local ENTRIES=($(ansible-inventory -i $INVENTORY_FILE --list | jq -c '._meta.hostvars | to_entries[] | {"name": .key, "ip": .value.ansible_host, "user": .value.ansible_user, "ident": .value.ansible_private_key_file}'))

  mkdir -p $CONFIG_DIRECTORY

  for entry in $ENTRIES; do
    if [ ${entry##*'windows'*} ]; then
      local name="$(echo $entry | jq -r '.name')"
      local splitName=("${(@f)$(helpers text split -d '_' "$name")}")
      local dc="$splitName[1]"
      local ip="$(echo $entry | jq -r '.ip')"
      local user="$(echo $entry | jq -r '.user')"
      local identFile="$(echo $entry | jq -r '.ident')"
      print_info "host" "$name@$ip"

      echo "Host $name" >> $CONFIG_DIRECTORY/$dc
      echo "  HostName $ip" >> $CONFIG_DIRECTORY/$dc
      if test "$identFile" != "null"; then
        echo "  IdentityFile $identFile" >> $CONFIG_DIRECTORY/$dc
      fi
      if test "$user" != "null"; then
        echo "  User $user" >> $CONFIG_DIRECTORY/$dc
      fi
      echo "" >> $CONFIG_DIRECTORY/$dc
    fi
  done
}
