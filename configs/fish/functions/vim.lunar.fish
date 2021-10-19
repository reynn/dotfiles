#!/usr/bin/env fish

function vim.lunar -d 'Cleanup files and reinstall LunarVim'
    set -x LUNARVIM_BRANCH rolling
    set -x LUNARVIM_CONFIG_DIR "$HOME/git/github.com/reynn/dotfiles/configs/lunar-vim"
    set -x LUNARVIM_RUNTIME_DIR "$HOME/.local/share/lunarvim"
    set -x PACKER_NVIM_DIR "$LUNARVIM_RUNTIME_DIR/site/pack/packer/start/packer.nvim"

    set CLEAN_CACHE false
    set CLEAN_PACKER false
    set CLEAN_LUNARVIM false
    set SETUP_LUNARVIM false
    set SETUP_PACKER false

    function ___setup_lunar_vim
        if test ! -d "$LUNARVIM_RUNTIME_DIR/lvim"
            __log info "Cloning LunarVim to $LUNARVIM_RUNTIME_DIR..."
            git clone --depth 1 --branch "$LUNARVIM_BRANCH" https://github.com/LunarVim/LunarVim "$LUNARVIM_RUNTIME_DIR/lvim"
            if test $status -gt 0
                __log error 'Failed to clone the `LunarVim/LunarVim` respository'
                return 1
            end
        else
            __log info "LunarVim is already available"
        end
    end

    function ___setup_packer_nvim
        if test ! -d "$PACKER_NVIM_DIR"
            __log info "Cloning Packer.nvim to $PACKER_NVIM_DIR..."
            git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_NVIM_DIR"
            if test $status -gt 0
                __log error 'Failed to clone the `packer.nvim` respository'
                return 1
            end
        else
            __log info "Packer.nvim is already available"
        end
    end

    function ___setup_lunar_vim_env
        set -Ux LUNARVIM_CONFIG_DIR "$LUNARVIM_CONFIG_DIR"
        set -Ux LUNARVIM_RUNTIME_DIR "$LUNARVIM_RUNTIME_DIR"
    end

    function ___usage
        set -l help_args -a 'Cleanup files and reinstall LunarVim [**UNSTABLE**]'

        set -a help_args -f 'a|setup-all|Run through all setup options in proper order|true'
        set -a help_args -f 'A|clean-all|Clean all directories (complete uninstall)|true'
        set -a help_args -f 'l|clean-lunarvim|Clean all existing LunarVim installation files|false'
        set -a help_args -f 'L|configure-lunarvim|Complete setup for the LunarVim configuration|false'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case a setup-all
                set CLEAN_CACHE true
                set SETUP_PACKER true
                set SETUP_LUNARVIM true
            case A clean-all
                set CLEAN_CACHE true
                set CLEAN_PACKER true
                set CLEAN_LUNARVIM true
            case l clean-lunarvim
                set CLEAN_CACHE true
                set CLEAN_LUNARVIM true
            case L configure-lunarvim
                set CLEAN_CACHE true
                set SETUP_PACKER true
                set SETUP_LUNARVIM true
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

    if test "$CLEAN_PACKER" = true
        rm -rf "$PACKER_NVIM_DIR"
    end

    if test "$CLEAN_LUNARVIM" = true
        rm -rf "$HOME/.config/nvim"
        rm -rf "$HOME/.local/share/nvim"
        rm -rf "$HOME/.local/nvim"
        rm -rf "$LUNARVIM_RUNTIME_DIR"
    end

    if test "$SETUP_LUNARVIM" = true
        ___setup_lunar_vim_env
        ___setup_lunar_vim
        ___setup_packer_nvim

        nvim --headless \
            -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" \
            -c 'autocmd User PackerComplete quitall' \
            -c PackerSync
    end
end
