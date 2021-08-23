#!/usr/bin/env fish

function dotfiles.path.update -d "Setup the fish_user_path variable"
    # Python exports
    set -Ux PYTHON_HOME (python3 -c 'import site; print(site.USER_BASE)')

    # These will add to the fish_user_paths only if necessary
    path.replace "$PYTHON_HOME/bin"
    fish_add_path "$DFP/scripts"
    fish_add_path "$HOME/.local/bin"
    fish_add_path "$HOME/.bins/envs"
    fish_add_path "$HOME/.cargo/bin"
    fish_add_path "$HOME/go/bin"

    command.is_available -c cargo; and fish_add_path "$HOME/.cargo/bin"

    __log debug "Checking for go versions in $go_versions_path"
    if test -d "$go_versions_path"
        set -l go_version (fd -td -d1 . --base-directory $go_versions_path | sort -r)
        if test (count $go_version) -gt 1
            set go_version $go_version[1]
        end
        __log debug "Go Version $go_version"
        path.replace "$go_versions_path/$go_version/bin" 2
    end

    __log debug "Checking for node versions in $node_versions_path"
    if test -d "$node_versions_path"
        set -l node_version (fd -td -d1 . --base-directory $node_versions_path | sort -r)
        if test (count $node_version) -gt 1
            set node_version $node_version[1]
        end
        __log debug "Node Version $node_version"
        path.replace "$node_versions_path/$node_version/bin" 2
    end

    # Setup Pyenv if it is available on the system
    if not command.is_available -c pyenv or test -x "$HOME/.pyenv/bin/pyenv"
        set -Ux PYENV_ROOT "$HOME/.pyenv"
        __log debug "Pyenv from $PYENV_ROOT"
        fish_add_path "$PYENV_ROOT/bin"
        fish_add_path "$PYENV_ROOT/shims"
    end
end
