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

    ## Python exports
    set -Ux PYTHON_HOME (python3 -c 'import site; print(site.USER_BASE)')

    # These will add to the fish_user_paths only if necessary
    fish_add_path "$GFP/github.com/junegunn/fzf/bin"
    fish_add_path "$DFP/scripts"
    fish_add_path "$HOME/.bins"
    fish_add_path "$HOME/.bins/envs"
    fish_add_path "$HOME/.cargo/bin"
    fish_add_path "$HOME/go/bin"
    path.replace "$PYTHON_HOME/bin"

    log.debug "Checking for go versions in $go_versions_path"
    if test -d "$go_versions_path"
        set -l go_version (fd -td -d1 . --base-directory $go_versions_path | sort -r)
        if test (count $go_version) -gt 1
            set go_version $go_version[1]
        end
        log.debug "Go Version $go_version"
        path.replace "$go_versions_path/$go_version/bin" 2
    end

    set -Ux GOPRIVATE '*.concur.com,*.wdf.sap.corp,*.tools.sap'

    log.debug "Checking for node versions in $node_versions_path"
    if test -d "$node_versions_path"
        set -l node_version (fd -td -d1 . --base-directory $node_versions_path | sort -r)
        if test (count $node_version) -gt 1
            set node_version $node_version[1]
        end
        log.debug "Node Version $node_version"
        path.replace "$node_versions_path/$node_version/bin" 2
    end

    for extra_path in $paths_to_add
        fish_add_path extra_path
    end

    ## Load any secrets
    source "$DFP/.host/$hostname.fish" 1&>>/dev/null; or log.debug 'Unable to load host values'
    source "$DFP/.secrets/__global.fish" 1&>>/dev/null; or log.debug 'Unable to load global secrets'
    source "$DFP/.secrets/$hostname.fish" 1&>>/dev/null; or log.debug 'Unable to load secrets'
end
