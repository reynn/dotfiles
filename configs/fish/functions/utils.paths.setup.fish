#!/usr/bin/env fish

function utils.paths.setup -d "Setup the fish_user_path variable"
    # Source additional files

    # These will add to the fish_user_paths only if necessary
    utils.path.add "$PYTHON_HOME/bin"
    utils.path.add "$DFP/scripts"
    utils.path.add "$HOME/.bins"
    utils.path.add "$HOME/.bins/envs"
    if test -e (command -v cargo)
        utils.path.add "$HOME/.cargo/bin"
    end
    if test -e (command -v fzf)
        utils.path.add "$GFP/github.com/junegunn/fzf/bin"
    end
    # Make sure Node is available always
    # This should happen regardless but is being weird for some reason
    if test -e (command -v node)
        utils.path.replace (node --version)
    end
end
