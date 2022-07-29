#!/usr/bin/env fish

function dotfiles.path.update -d "Setup the fish_user_path variable"
    # Python exports
    set -Ux PYTHON_HOME (python3 -c 'import site; print(site.USER_BASE)')
    set -l os_name (uname | string lower)

    set -l go_version_path "$HOME/.gimme/versions/go$LANGUAGES_GO_VERSION.$os_name.amd64/bin"
    set -l node_version_path "$HOME/.local/share/nvm/v$LANGUAGES_NODE_VERSION/bin"
    set -l node_pnpm_path "$HOME/Library/pnpm"

    # These will add to the fish_user_paths only if necessary
    path.replace "$PYTHON_HOME/bin" 2
    set -l user_paths "$DFP/scripts" "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/go/bin"
    if test -e (which vers)
        set -l vers_path (vers env -n global -s fish)
        set -a user_paths (string replace -r '.*?\"(.+)\"' '$1' $vers_path)
    end

    __log debug "Paths to add :: $user_paths"

    for u_path in $user_paths
        if not contains -- "$u_path" $fish_user_paths
            __log debug "Adding $u_path"
            fish_add_path -pm "$u_path"
        else
            __log debug "Skipped adding '$u_path'"
        end
    end

    __log debug "Checking for Go version path: $go_version_path"
    if test -e "$go_version_path"
        path.replace "$go_version_path" 2
        set -Ux GOROOT (dirname $go_version_path)
    end
    __log debug "Checking for Node version path: $node_version_path"
    test -e "$node_version_path"; and path.replace "$node_version_path" 2

    __log debug "Checking for PNPM for Node"
    if test -d "$node_pnpm_path"
        set -Ux PNPM_HOME "$node_pnpm_path"
        fish_add_path -pm "$node_pnpm_path"
    end

    __log debug "Checking for Cargo install"
    command.is_available -c cargo; and fish_add_path "$HOME/.cargo/bin"
end
