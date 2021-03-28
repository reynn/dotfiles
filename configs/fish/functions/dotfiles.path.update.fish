#!/usr/bin/env fish

function dotfiles.path.update -d "Setup the fish_user_path variable"
    # Source additional files

    # These will add to the fish_user_paths only if necessary
    fish_add_path "$PYTHON_HOME/bin"
    fish_add_path "$DFP/scripts"
    fish_add_path "$HOME/.bins/envs"

    if test -e (command -v cargo)
        fish_add_path "$HOME/.cargo/bin"
    end

    if test -e (command -v fzf)
        fish_add_path "$GFP/github.com/junegunn/fzf/bin"
    end
end
