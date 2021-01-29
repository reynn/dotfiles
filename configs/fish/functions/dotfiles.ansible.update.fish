#!/usr/bin/env fish

function dotfiles.ansible.update -d 'Run the playbook to apply latest changes'
    set -x tags
    set -x verbose 0
    set -x ansible_args "$DFP/ansible/config.yaml"

    function ___usage -d 'Show a help message'
        set -l help_args -f 'h|help|Print this help message'
        set -a help_args -f 't|tags|Tags to run instead of full playbook|$tags'
        set -a help_args -e " --tags scripts,links     # Run the Ansible playbook with just the links and scripts tags"
        set -a help_args -e " -vvv --tags links        # Run the Ansible playbook with just the links tag with additional verbosity levels"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case _
                set -a ansible_args "$value"
            case t tags
                set tags "$value"
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

    if test $verbose -gt 0
        set -x DEBUG true
        set -a ansible_args "-"(string repeat 'v' -n $verbose)
    end

    if test -n "$tags"
        set -a ansible_args --tags
        set -a ansible_args $tags
    end

    log.debug (count ansible_args)" arguments ($ansible_args)"
    log.debug "ANSIBLE_CONFIG=$DFP/ansible/ansible.cfg ansible-playbook $ansible_args"
    ANSIBLE_CONFIG=$DFP/ansible/ansible.cfg ansible-playbook $ansible_args
end
