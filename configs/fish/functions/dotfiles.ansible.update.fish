#!/usr/bin/env fish

function dotfiles.update -d 'Run the playbook to apply latest changes'
    set -lx tags
    set -lx verbose 0
    set -lx ansible_args "$DFP/ansible/config.yaml"

    function ___usage -d 'Show a help message'
        set -l help_args '-f' 'h|help|Print this help message'
        set -a help_args '-f' 't|tags|Tags to run instead of full playbook|$tags'
        set -a help_args '-f' 'K|become|Run as sudo after asking for password|false'
        set -a help_args '-e' " --tags scripts,links     # Run the Ansible playbook with just the links and scripts tags"
        set -a help_args '-e' " -vvv --tags links        # Run the Ansible playbook with just the links tag with additional verbosity levels"
        set -a help_args '-c' '2|Missing Configuration'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case h helps
                ___usage
                return 0
            case t tags
                set tags $value
            case K become
                set -a ansible_args '-K'
            case v verbose
                set verbose (math $verbose + 1)
        end
    end

    if test $verbose -gt 0
        set -x DEBUG 'true'
        set -a ansible_args "-"(string repeat 'v' -n $verbose)
    end

    if test -n "$tags"
        set -a ansible_args '--tags'
        set -a ansible_args $tags
    end

    log.debug -m (count ansible_args)" arguments ($ansible_args)"
    log.debug -m "ANSIBLE_CONFIG=$DFP/ansible/ansible.cfg ansible-playbook $ansible_args"
    ANSIBLE_CONFIG=$DFP/ansible/ansible.cfg ansible-playbook $ansible_args
end
