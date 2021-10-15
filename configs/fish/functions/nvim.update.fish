#!/usr/bin/env fish

function nvim.update -d 'Cleanup files and reinstall Spacevim'
    set -x SYSTEM_CONFIG_DIR (set -q XDG_CONFIG_HOME; and echo "$XDG_CONFIG_HOME"; or echo "$HOME/.config")
    set -x SYSTEM_CACHE_DIR (set -q XDG_CACHE_HOME; and echo "$XDG_CACHE_HOME"; or echo "$HOME/.cache")
    set -x DFP_NVIM_CONFIG "$DFP/configs/lunar-vim"
    set -x NEOVIM_HOME "$SYSTEM_CONFIG_DIR/nvim"
    set -x NEOVIM_CACHE "$SYSTEM_CACHE_DIR/nvim"
    set -x RM_COMMAND (command -s rm)
    set -x LVIM_BRANCH rolling
    set -x LVIM_SCRIPT_URL "https://raw.githubusercontent.com/lunarvim/lunarvim/$LVIM_BRANCH/utils/installer/install.sh"

    set -x CLEAN_CACHE false
    set -x CLEAN_NVIM false
    set -x CONFIGURE_NVIM false

    function ___install_lunar_vim
        set -l install_script_path (mktemp -t lunarvim)
        __log info "Downloading LunarVim script to $install_script_path"
        curl -Ss $LVIM_SCRIPT_URL >$install_script_path
        chmod +x $install_script_path
        $install_script_path --overwrite
    end

    function ___nvim_clean_files_delete
        # Get a handle to the builtin rm command instead of an alias
        set -l item_name "$argv[1]"
        if test -d $item_name
            __log "Deleting directory $item_name"
            $RM_COMMAND -rf $item_name
        else if test -f $item_name
            __log "Deleting file $item_name"
            $RM_COMMAND -f $item_name
        else
            __log "$item_name doesn't need to be deleted"
        end
    end

    function ___usage
        set -l help_args -a 'Cleanup files and reinstall LunarVim [**UNSTABLE**]'
        set -a help_args -f "A|all|Perform all actions (Clean update)|true"
        set -a help_args -f "N|clean-nvim|Clean NVIM related files|$CLEAN_NVIM"
        set -a help_args -f "C|clean-cache|Clean all cache files|$CLEAN_CACHE"
        set -a help_args -f "n|configure-nvim|Ensure NVIM is configured|$CONFIGURE_NVIM"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case A all
                set CLEAN_NVIM true
                set CLEAN_CACHE true
                set CONFIGURE_NVIM true
            case c clean-cache
                set CLEAN_CACHE true
            case C clean-all
                set CLEAN_NVIM true
                set CLEAN_CACHE true
            case N clean-nvim
                set CLEAN_NVIM true
            case n configure-nvim
                set CONFIGURE_NVIM true
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

    __log debug "CLEAN_CACHE        : $CLEAN_CACHE"
    __log debug "CLEAN_NVIM         : $CLEAN_NVIM"
    __log debug "CONFIGURE_NVIM     : $CONFIGURE_NVIM"

    if test "$CLEAN_NVIM" = true
        __log debug 'Deleting NeoVim files'
        ___nvim_clean_files_delete "$NEOVIM_CACHE"
        ___nvim_clean_files_delete "$HOME/.local/share/nvim"
        ___nvim_clean_files_delete "$HOME/.local/share/lunarvim"
        ___nvim_clean_files_delete "$HOME/.config/lvim"
        ___nvim_clean_files_delete "$HOME/.local/bin/lvim"
    end

    if test "$CONFIGURE_NVIM" = true
        ## Install the LunarVim base
        ___install_lunar_vim
        ## Ensure our paths exist before linking
        mkdir -p $HOME/.config/lvim/ftplugin
        ## Symlink the main config.lua file
        symlink.create -s "$DFP/configs/lunar-vim/config.lua" -d "$HOME/.config/lvim/config.lua"
        ## Symlink anything in ftplugin
        for ftplugin in (fd -a -tf -e lua . --base-directory $DFP_NVIM_CONFIG/ftplugin)
            symlink.create -s $ftplugin -d "$HOME/.config/lvim/ftplugin/"(basename $ftplugin)
        end
    end
end
