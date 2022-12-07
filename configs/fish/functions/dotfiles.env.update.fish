#!/usr/bin/env fish

function dotfiles.env.update -d 'Setup global/universal variables'
    set -x paths_to_add
    set -x go_versions_path "$HOME/.gimme/versions"
    set -x node_versions_path "$HOME/.local/share/nvm"

    function ___usage
        set -l help_args -a 'Setup global/universal variables'
        set -l help_args -f 'P|path|Ensure paths are in fish_user_paths'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case go_versions_path
                set go_versions_path "$value"
            case node_versions_path
                set node_versions_path "$value"
            case P path
                set -a paths_to_add "$value"
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

    set -Ux SCRATCH_DIRECTORY "$DFP/.scratch"
    if not test -d $SCRATCH_DIRECTORY
        mkdir -p $SCRATCH_DIRECTORY
        touch $SCRATCH_DIRECTORY/scratch.{rs,go,py,yaml,json,toml,txt,md}
    end

    set -Ux GFP "$HOME/git"
    set -Ux DFP "$GFP/github.com/reynn/dotfiles"

    set -Ux ZELLIJ_CONFIG_DIR "$DFP/configs/zellij"

    ## Language versions
    set -Ux LANGUAGES_PYTHON_VERSION '3.11'
    set -Ux LANGUAGES_GO_VERSION '1.19.4'
    set -Ux LANGUAGES_RUST_VERSION '1.65.0'
    set -Ux LANGUAGES_NODE_VERSION '19.2.0'

    set -Ux GOPRIVATE '*.concur.com,*.wdf.sap.corp,*.tools.sap'

    ## Load any secrets
    source "$DFP/.host/$hostname.fish" 1&>>/dev/null; or __log debug 'Unable to load host values'
    source "$DFP/.secrets/__global.fish" 1&>>/dev/null; or __log debug 'Unable to load global secrets'

    dotfiles.path.update
end
