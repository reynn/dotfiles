#!/usr/bin/env fish

function dotfiles.path.update -d "Setup the fish_user_path variable"
    # Python exports
    set -Ux PYTHON_HOME (python3 -c 'import site; print(site.USER_BASE)')
    set -l os_name (uname | string lower)

    set -l go_version_path "$HOME/.gimme/versions/go$LANGUAGES_GO_VERSION.$os_name.amd64/bin"
    set -l node_version_path "$HOME/.local/share/nvm/v$LANGUAGES_NODE_VERSION/bin"

    # These will add to the fish_user_paths only if necessary
    path.replace "$PYTHON_HOME/bin" '2'
    fish_add_path "$DFP/scripts"
    fish_add_path "$HOME/.local/bin"
    fish_add_path "$HOME/.cargo/bin"
    fish_add_path "$HOME/go/bin"
    if test -e (which vers)
      fish_add_path "$(vers env -s fish)"
    end

    __log debug "Checking for Go version path: $go_version_path"
    if test -e "$go_version_path"
        path.replace "$go_version_path" '2'
        set -Ux GOROOT (dirname $go_version_path)
    end
    __log debug "Checking for Node version path: $node_version_path"
    test -e "$node_version_path"; and path.replace "$node_version_path" '2'
    __log debug "Checking for Cargo install"
    command.is_available -c cargo; and fish_add_path "$HOME/.cargo/bin"
end
