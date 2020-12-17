#!/usr/bin/env fish

function dotfiles.env.update -d 'Setup global/universal variables'
    set -lx paths_to_add
    set -lx go_versions_path "$HOME/.gimme/versions"
    set -lx node_versions_path "$HOME/.local/share/nvm"

    function ___usage
        set -l help_args '-a' 'Setup global/universal variables'
        set -l help_args '-f' 'P|path|Ensure paths are in fish_user_paths'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case go_versions_path
                set go_versions_path "$value"
            case node_versions_path
                set node_versions_path "$value"
            case P path
                set -a paths_to_add "$value"
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
    end

    ## Language versions
    set -Ux LANGUAGES_PYTHON_VERSION '3.9'
    set -Ux LANGUAGES_GO_VERSION '1.15'
    set -Ux LANGUAGES_RUST_VERSION '1.48'

    ## Python exports
    set -Ux PYTHON_HOME (python3 -c 'import site; print(site.USER_BASE)')

    # These will add to the fish_user_paths only if necessary
    utils.path.add "$GFP/github.com/junegunn/fzf/bin"
    utils.path.add "$DFP/scripts"
    utils.path.add "$HOME/.bins"
    utils.path.add "$HOME/.bins/envs"
    utils.path.add "$HOME/.cargo/bin"
    utils.path.replace "$PYTHON_HOME/bin"

    log.debug -m "Checking for go versions in $go_versions_path"
    if test -d "$go_versions_path"
        set -l go_version (find $go_versions_path -type d -depth 1 | xargs -L1 basename | sort -r)
        if test (count $go_version) -gt 1
            set go_version $go_version[1]
        end
        log.debug -m "Go Version $go_version"
        utils.path.replace "$go_versions_path/$go_version/bin" '2'
    end

    log.debug -m "Checking for node versions in $node_versions_path"
    if test -d "$node_versions_path"
        set -l node_version (find $node_versions_path -type d -depth 1 | xargs -L1 basename | sort -r)
        if test (count $node_version) -gt 1
            set node_version $node_version[1]
        end
        log.debug -m "Node Version $node_version"
        utils.path.replace "$node_versions_path/$node_version/bin" '2'
    end

    for extra_path in $paths_to_add
        utils.path.add "extra_path"
    end
end
