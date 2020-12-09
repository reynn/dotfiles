#!/usr/bin/env fish

function dotfiles.env.update -d 'Setup global/universal variables'
    set -lx paths_to_add

    function ___usage
        set -l help_args '-a' 'Setup global/universal variables'
        set -l help_args '-f' 'P|path|Ensure paths are in fish_user_paths'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case P path
                set -a paths_to_add "$value"
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
    end

    # Exports
    ## General ENV vars
    set -Ux GFP "$HOME/git"
    set -Ux DFP "$GFP/github.com/reynn/dotfiles"
    set -Ux REYNN "$GFP/github.com/reynn"

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
    utils.path.add "$PYTHON_HOME/bin"
    if functions -q nvm
        set -l latest_node_version (nvm list | grep 'latest' | awk '{print $1}')
        utils.path.add "$HOME/.local/share/nvm/$latest_node_version/bin"
    end

    for extra_path in $paths_to_add
        utils.path.add "extra_path"
    end
end
