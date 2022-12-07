#!/usr/bin/env fish

function completions.update -d 'Update completions for available binaries'
    set -x show_all_completions false

    function ___usage
        set -l help_args -a 'Update completions for available binaries'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
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

    if test -e (which gh)
        __log "Generating `gh` completions"
        gh completion --shell fish >$DFP/configs/fish/completions/gh.fish
    end
    if test -e (which dasel)
        __log "Generating `dasel` completions"
        dasel completion fish >$DFP/configs/fish/completions/dasel.fish
    end
    if test -e (which doctl)
        __log "Generating `doctl` completions"
        doctl completion fish >$DFP/configs/fish/completions/doctl.fish
    end
    if test -e (which fd)
        __log "Generating `fd` completions"
        fd --gen-completions >$DFP/configs/fish/completions/fd.fish
    end
    if test -e (which helm)
        __log "Generating `helm` completions"
        helm completion fish >$DFP/configs/fish/completions/helm.fish
    end
    if test -e (which rustup)
        __log "Generating `rustup` completions"
        rustup completions fish >$DFP/configs/fish/completions/rustup.fish
    end
    if test -e (which zellij)
        __log "Generating `zellij` completions"
        zellij setup --generate-completion fish >$DFP/configs/fish/completions/zellij.fish
    end
    if test -e (which vers)
        __log "Generating `vers` completions"
        vers completions --shell fish >$DFP/configs/fish/completions/vers.fish
    end
    if test -e (which stern)
        __log "Generating `stern` completions"
        stern --completion fish >$DFP/configs/fish/completions/stern.fish
    end
end
