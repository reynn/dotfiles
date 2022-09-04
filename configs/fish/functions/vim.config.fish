#!/usr/bin/env fish

function vim.config -d 'Configure NeoVIM with Cheovim and other configs'
    set -lx DOTFILES_CONFIG_DIR "$DFP/configs"
    set -lx NVIM_CONFIG_DIR "$HOME/.config/nvim"
    set -lx CHEOVIM_LOCAL_DIR "$HOME/.local/share/nvim/cheovim"
    set -l CONFIGURATION_OPTIONS doomnvim astronvim lunarvim
    set -l CONFIGURATIONS

    function ___usage
        set -l help_args -a 'Cleanup files and reinstall AstroNvim [**UNSTABLE**]'

        set -a help_args -f "c|config|Install some of the configurations; Available options ($CONFIGURATION_OPTIONS)|"
        set -a help_args -f 'C|clean|Clean all directories (complete uninstall)|true'

        __dotfiles_help $help_args
    end

    function packer_sync
        nvim --headless \
            -c 'autocmd User PackerComplete quitall' \
            -c PackerSync
    end

    function setup_cheovim
        git clone --depth=1 https://github.com/NTBBloodbath/cheovim "$NVIM_CONFIG_DIR"
        symlink.create \
            -s "$DOTFILES_CONFIG_DIR/cheovim/profiles.lua" \
            -d "$NVIM_CONFIG_DIR/profiles.lua"
    end

    function setup_astronvim
        git clone https://github.com/AstroNvim/AstroNvim $CHEOVIM_LOCAL_DIR/astronvim
        symlink.create \
            -s $DOTFILES_CONFIG_DIR/astronvim \
            -d $CHEOVIM_LOCAL_DIR/astronvim/lua/user
    end

    function setup_doomnvim
        git clone https://github.com/NTBBloodbath/doom-nvim.git $CHEOVIM_LOCAL_DIR/doomnvim
        symlink.create \
            -s $DOTFILES_CONFIG_DIR/doomnvim/config.lua \
            -d $CHEOVIM_LOCAL_DIR/doomnvim/config.lua
        symlink.create \
            -s $DOTFILES_CONFIG_DIR/doomnvim/modules.lua \
            -d $CHEOVIM_LOCAL_DIR/doomnvim/modules.lua
    end

    function setup_lunarvim
        git clone https://github.com/LunarVim/LunarVim.git $CHEOVIM_LOCAL_DIR/lunarvim
        symlink.create \
            -s $DOTFILES_CONFIG_DIR/lunar-vim/config.lua \
            -d $CHEOVIM_LOCAL_DIR/lunarvim/config.lua
    end

    function clean
        rm -rf "$HOME/.cache/nvim"
        rm -rf "$HOME/.config/nvim"
        rm -rf "$HOME/.local/share/nvim"
    end

    getopts $argv | while read -l key value
        switch $key
            case C clean
                clean
                return
            case c config
                set -p CONFIGURATIONS "$value"
            case h help
                ___usage
                return 0
            case q quiet
                set -l QUIET true
            case v verbose
                set -l DEBUG true
        end
    end

    set -l configs_setup
    setup_cheovim
    for config in $CONFIGURATIONS
        __log "Setting up $config"
        switch $config
            case lunarvim
                setup_lunarvim
                set configs_setup true
            case doomnvim
                setup_doomnvim
                set configs_setup true
            case astronvim
                setup_astronvim
                set configs_setup true
        end
    end

    if test "$configs_setup"
        __log "Running PackerSync"
        packer_sync
    end
end
