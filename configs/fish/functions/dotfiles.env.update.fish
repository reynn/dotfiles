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
    set -gx GFP "$HOME/git"
    set -gx DFP "$GFP/github.com/reynn/dotfiles"
    set -gx REYNN "$GFP/github.com/reynn"
    set TERM 'screen-256color'
    set EDITOR 'nvim'

    ## Language versions
    set -Ux LANGUAGES_PYTHON_VERSION '3.9'
    set -Ux LANGUAGES_GO_VERSION '1.15'
    set -Ux LANGUAGES_RUST_VERSION '1.48'

    ## Python exports
    set -Ux PYTHON_HOME (python3 -m site | string replace --filter -r 'USER_BASE\: \'(.+?)\'( \(exists\))?' \$1)

    # These will add to the fish_user_paths only if necessary
    utils.path.add "$GFP/github.com/junegunn/fzf/bin"
    utils.path.add "$DFP/scripts"
    utils.path.add "$HOME/.bins"
    utils.path.add "$HOME/.bins/envs"
    utils.path.add "$HOME/.cargo/bin"
    utils.path.add "$GFP/github.com/junegunn/fzf/bin"

    for extra_path in $paths_to_add
        utils.path.add "extra_path"
    end
end
