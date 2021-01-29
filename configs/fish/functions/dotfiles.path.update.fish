#!/usr/bin/env fish

function dotfiles.path.update -d "Setup the fish_user_path variable"
    # Source additional files

    # These will add to the fish_user_paths only if necessary
    path.add "$PYTHON_HOME/bin"
    path.add "$DFP/scripts"
    path.add "$HOME/.bins/envs"

    if test -e (command -v cargo)
        path.add "$HOME/.cargo/bin"
    end

    if test -e (command -v fzf)
        path.add "$GFP/github.com/junegunn/fzf/bin"
    end
end
