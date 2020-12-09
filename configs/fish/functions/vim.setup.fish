function vim.setup -d 'Cleanup files and reinstall Spacevim'
    set -lx SPACEVIM_INIT_PATH "$DFP/configs/spacevim"
    set -lx SYSTEM_CONFIG_DIR (set -q XDG_CONFIG_HOME; and echo "$XDG_CONFIG_HOME"; or echo "$HOME/.config")
    set -lx SYSTEM_CACHE_DIR (set -q XDG_CACHE_HOME; and echo "$XDG_CACHE_HOME"; or echo "$HOME/.cache")
    set -lx NEOVIM_HOME "$SYSTE_CONFIG_DIR/nvim"
    set -lx NEOVIM_CACHE "$SYSTE_CACHE_DIR/nvim"
    set -lx PYTHON_VENV_PATH "$NEOVIM_CACHE/py3-env"
    set -lx rm_command (command -s rm)

    function ___usage
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case h help
                ___usage
                return 0
            case v verbose
                set -x DEBUG 'true'
        end
    end

    function __vim_clean_files_delete
        # Get a handle to the builtin rm command instead of an alias
        set -l item_name "$argv[1]"
        if test -d $item_name
            log.info -m "Deleting directory $item_name"
            $rm_command -rf $item_name
        else if test -f $item_name
            log.info -m "Deleting file $item_name"
            $rm_command -f $item_name
        else
            log.info -m "$item_name doesn't need to be deleted"
        end
    end

    log.info -m 'Deleting Vim files'
    __vim_clean_files_delete "$HOME/.vim"

    log.info -m 'Deleting NeoVim files'
    
    __vim_clean_files_delete "$NEOVIM_HOME"
    __vim_clean_files_delete "$HOME/.local/share/nvim"

    log.info -m 'Deleting SpaceVim files'
    __vim_clean_files_delete "$HOME/.Spacevim.d"
    __vim_clean_files_delete "$HOME/.Spacevim"

    log.info -m 'Deleting cache files'
    __vim_clean_files_delete "$HOME/.cache/vimfiles"
    __vim_clean_files_delete "$HOME/.cache/SpaceVim"

    log.info -m 'Deleting CoC.nvim files'
    __vim_clean_files_delete "$SYSTEM_CONFIG_DIR/coc/extensions"

    log.info -m 'Linking custom config to default spacevim config'
    ln -s $SPACEVIM_INIT_PATH $HOME/.SpaceVim.d

    log.info -m 'Re-linking SpaceVim for Neovim'
    ln -s $HOME/.SpaceVim $NEOVIM_HOME/nvim

    if test -d "$PYTHON_VENV_PATH"
        log.info -m "Deleting python virtual environment $PYTHON_VENV_PATH"
        $rm_command -rf $PYTHON_VENV_PATH
    end

    log.info -m "Creating python virtual environment $PYTHON_VENV_PATH"
    mkdir -p (dirname $PYTHON_VENV_PATH)
    python3 -m venv $PYTHON_VENV_PATH
    source "$PYTHON_VENV_PATH/bin/activate.fish"
    python -m pip install -U neovim pip
    deactivate

    log.info -m 'Installing Spacevim'
    if test -x (command -s installer.spacevim)
        $HOME/.bins/installer.spacevim
    else
        log.error -m 'There is an issue with the SpaceVim installer, please run `dotfiles.update --tags scripts`'
    end
end
