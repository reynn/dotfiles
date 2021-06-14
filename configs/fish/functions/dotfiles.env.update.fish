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

    set -Ux GFP "$HOME/git"
    set -Ux DFP "$GFP/github.com/reynn/dotfiles"

    ## Language versions
    set -Ux LANGUAGES_PYTHON_VERSION '3.9'
    set -Ux LANGUAGES_GO_VERSION '1.16'
    set -Ux LANGUAGES_RUST_VERSION '1.52'

    # 
    set -Ux GOPRIVATE '*.concur.com,*.wdf.sap.corp,*.tools.sap'

    ## Load any secrets
    source "$DFP/.host/$hostname.fish" 1&>>/dev/null; or log debug 'Unable to load host values'
    source "$DFP/.secrets/__global.fish" 1&>>/dev/null; or log debug 'Unable to load global secrets'
    source "$DFP/.secrets/$hostname.fish" 1&>>/dev/null; or log debug 'Unable to load secrets'

    dotfiles.path.update
end
