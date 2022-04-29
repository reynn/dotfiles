#!/usr/bin/env fish

function vim.config -d 'Configure NeoVIM with Cheovim and other configs'
    set -x DOTFILES_CONFIG_DIR "$DFP/configs/"
    set -x NVIM_CONFIG_DIR "$HOME/.config/nvim/"
    set -x CHEOVIM_LOCAL_DIR "$HOME/.local/share/nvim/cheovim/"
    set -x CLEAN_CACHE false
    set -x CLEAN_LOCAL false
    set -x SETUP_ASTRONVIM false
    set -x SETUP_DOOMNVIM false
    set -x SETUP_LUNARVIM false
    set -x SETUP_CHEOVIM false

    function ___usage
        set -l help_args -a 'Cleanup files and reinstall AstroVim [**UNSTABLE**]'

        set -a help_args -f 'a|setup-all|Run through all setup options in proper order|true'
        set -a help_args -f 'A|clean-all|Clean all directories (complete uninstall)|true'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case a setup-all
                set SETUP_CHEOVIM true
                set SETUP_ASTRONVIM true
                set SETUP_DOOMNVIM true
                set SETUP_LUNARVIM true
            case A clean-all
                set CLEAN_CACHE true
                set CLEAN_LOCAL true
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
        end
    end

    if test "$CLEAN_CACHE" = true
        rm -rf "$HOME/.cache/nvim"
    end

    if test "$CLEAN_LOCAL" = true
        rm -rf "$HOME/.config/nvim"
        rm -rf "$HOME/.local/share/nvim"
    end

    if test "$SETUP_CHEOVIM" = true
        git clone https://github.com/NTBBloodbath/cheovim "$NVIM_CONFIG_DIR"
        symlink.create \
            -s "$DOTFILES_CONFIG_DIR/cheovim/profiles.lua" \
            -d "$NVIM_CONFIG_DIR/profiles.lua"
        nvim --headless \
            -c 'autocmd User PackerComplete quitall' \
            -c PackerSync
    end

    if test "$SETUP_ASTRONVIM" = true
        symlink.create \
            -s $DOTFILES_CONFIG_DIR/astrovim \
            -d $CHEOVIM_LOCAL_DIR/astronvim/lua/user
    end

    if test "$SETUP_DOOMNVIM" = true

    end

    if test "$SETUP_LUNARVIM" = true
        mkdir $CHEOVIM_LOCAL_DIR/lunarvim
        symlink.create \
            -s $DOTFILES_CONFIG_DIR/lunar-vim/config.lua \
            -d $CHEOVIM_LOCAL_DIR/lunarvim/config.lua
    end

end
