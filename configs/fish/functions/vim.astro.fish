#!/usr/bin/env fish

function vim.astro -d 'Cleanup files and reinstall AstroVim'
    set -x DOTFILES_CONFIG_DIR "$DFP/configs/astrovim"
    set -x NVIM_CONFIG_DIR "$HOME/.config/nvim"

    set CLEAN_CACHE false
    set CLEAN_LOCAL false
    set SETUP_ASTROVIM false

    function ___setup_astro_vim
        if test ! -d "$NVIM_CONFIG_DIR"
            __log info "Cloning AstroVim to $NVIM_CONFIG_DIR ..."
            git clone --depth 1 https://github.com/kabinspace/AstroVim "$NVIM_CONFIG_DIR"
            if test $status -gt 0
                __log error 'Failed to clone the `kabinspace/AstroVim` respository'
                return 1
            end
        else
            __log info "AstroVim is already available"
        end
    end

    function ___setup_astro_vim_config
        symlink.create -s $DOTFILES_CONFIG_DIR/ -d $NVIM_CONFIG_DIR/lua/user
    end

    function ___usage
        set -l help_args -a 'Cleanup files and reinstall AstroVim [**UNSTABLE**]'

        set -a help_args -f 'a|setup-all|Run through all setup options in proper order|true'
        set -a help_args -f 'A|clean-all|Clean all directories (complete uninstall)|true'
        set -a help_args -f 'l|clean-vim|Clean all existing AstroVim installation files|false'
        set -a help_args -f 'L|configure-vim|Complete setup for the AstroVim configuration|false'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case a setup-all
                set CLEAN_CACHE true
                set CLEAN_LOCAL true
                set SETUP_ASTROVIM true
            case A clean-all
                set CLEAN_CACHE true
                set CLEAN_LOCAL true
            case l clean-astrovim
                set CLEAN_CACHE true
                set CLEAN_LOCAL true
            case L configure-astrovim
                set CLEAN_CACHE true
                set CLEAN_LOCAL true
                set SETUP_ASTROVIM true
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

    if test "$CLEAN_LOCAL" = true
        rm -rf "$HOME/.cache/nvim"
        rm -rf "$HOME/.config/nvim"
        rm -rf "$HOME/.local/share/nvim"
        rm -rf "$HOME/.local/nvim"
    end

    if test "$SETUP_ASTROVIM" = true
        ___setup_astro_vim
        ___setup_astro_vim_config

        nvim --headless \
            -c 'autocmd User PackerComplete quitall' \
            -c PackerSync
    end
end
