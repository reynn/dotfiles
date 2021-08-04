#!/usr/bin/env fish

function k8s.ctx.change -d "Set KUBECTX env variable as well as the active context based on selected items"
    set -x kubeconfig_path ~/.kube
    set -x kubeconfig_files ~/.kube/config
    set -x no_kubeconfig_file false

    function ___usage
        set -l help_args -a "Set KUBECTX env variable as well as the active context based on selected items"

        set -a help_args -f "p|kubeconfig-path|The path containing potential Kubeconfig files|$kubeconfig_path"
        set -a help_args -f "k|kubeconfig|What to set KUBECTX variable to, as well as where to look for contexts|$kubeconfig_file"
        set -a help_args -f "K|no-kubeconfig|Remove the default and search ~/.kube for files|$no_kubeconfig_file"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case k kubeconfig
                set kubeconfig_file "$value"
            case K no-kubeconfig
                set no_kubeconfig_file true
            case p kubeconfig-path
                set kubeconfig_path "$value"
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

    if test -z $kubeconfig_file; or test $no_kubeconfig_file = true
        __log "No Kubeconfig, searching"
        set kubeconfig_files (fd --absolute-path -tf -d1 . --base-directory $kubeconfig_path | sk --height 35% --multi --select-1)
    end

    __log debug "kubeconfig_file    : $kubeconfig_file"
    __log debug "no_kubeconfig_file : $no_kubeconfig_file"
    __log debug "kubeconfig_files   : "(count $kubeconfig_files)

    set -xg KUBECONFIG (string join ':' $kubeconfig_files)

    set context (kubectl config get-contexts -o name | sk --height 35% --select-1)
    if test -z $context
        kubectl config use-context $context
    end
end
