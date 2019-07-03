function update-dotfiles() {
  local tags=${1:-update}
  if [ "$tags" = '-h' ]; then
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Description | Update dotfiles, can provide a comma separate list of tags."
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Usage       | $0"
    print_usage "$0" "------------------------------------------------------------------"
    return 0
  fi

  ANSIBLE_CONFIG=$DFP/ansible.cfg ansible-playbook $DFP/playbook-config.yaml --tags $tags
}