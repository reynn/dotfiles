#!/usr/bin/env fish

function vim.config -d 'Configure NeoVIM with Cheovim and other configs'
    set -lx DOTFILES_CONFIG_DIR "$DFP/configs"
    set -lx NVIM_CONFIG_DIR "$HOME/.config/nvim"
    set -lx ASTRONVIM_REPO "https://github.com/AstroNvim/AstroNvim"
    set -l CONFIGURATIONS

    function ___usage
        set -l help_args -a 'Cleanup files and reinstall AstroNvim [**UNSTABLE**]'
        set -a help_args -f 'C|clean|Clean all directories (complete uninstall)|true'
        __dotfiles_help $help_args
    end

    function clean
        rm -rf ~/.cache/nvim
        rm -rf ~/.config/nvim
        rm -rf ~/.local/share/nvim
        rm -rf ~/.local/state/nvim
    end

    getopts $argv | while read -l key value
        switch $key
            case C clean
                clean
                return
            case h help
                ___usage
                return 0
            case q quiet
                set -l QUIET true
            case v verbose
                set -l DEBUG true
        end
    end

    if test ! -d $NVIM_CONFIG_DIR
        __log "Cloning $ASTRONVIM_REPO to $NVIM_CONFIG_DIR"
        git clone $ASTRONVIM_REPO $NVIM_CONFIG_DIR

        __log "Running initial PackerSync"
        nvim -c 'autocmd User PackerComplete quitall'
    else
        __log "AstroNVim already cloned"
    end

    if test ! -L "$NVIM_CONFIG_DIR/lua/user"
        __log "Symlinking AstroNVIM user config"
        symlink.create -s $DOTFILES_CONFIG_DIR/astronvim -d $NVIM_CONFIG_DIR/lua/user

        __log "Running user PackerSync"
        nvim -c 'autocmd User PackerSync quitall' -c PackerSync
    end
end
