#!/usr/bin/env fish

function vim.update -d 'Cleanup files and reinstall Spacevim'
    set -x SPACEVIM_INIT_PATH "$DFP/configs/spacevim"
    set -x SYSTEM_CONFIG_DIR (set -q XDG_CONFIG_HOME; and echo "$XDG_CONFIG_HOME"; or echo "$HOME/.config")
    set -x SYSTEM_CACHE_DIR (set -q XDG_CACHE_HOME; and echo "$XDG_CACHE_HOME"; or echo "$HOME/.cache")
    set -x NEOVIM_HOME "$SYSTEM_CONFIG_DIR/nvim"
    set -x NEOVIM_CACHE "$SYSTEM_CACHE_DIR/nvim"
    set -x PYTHON_VENV_PATH "$NEOVIM_CACHE/py3-env"
    set -x rm_command (command -s rm)

    set -x CLEAN_AND_CONFIGURE 'true'
    set -x CLEAN_CACHE 'false'
    set -x CLEAN_NVIM 'false'
    set -x CLEAN_VIM 'false'
    set -x CLEAN_SPACEVIM 'false'
    set -x CONFIGURE_SPACEVIM 'false'
    set -x CONFIGURE_VIM 'false'
    set -x CONFIGURE_NVIM 'false'

    function __vim_create_venv
        set -l venv_path "$argv[1]"
        log.info "Creating python virtual environment $venv_path"
        mkdir -p (dirname $venv_path)
        python3 -m venv $venv_path
        source "$venv_path/bin/activate.fish"
        python -m pip install -U neovim pip
        deactivate
    end

    function __vim_clean_files_delete
        # Get a handle to the builtin rm command instead of an alias
        set -l item_name "$argv[1]"
        if test -d $item_name
            log.info "Deleting directory $item_name"
            $rm_command -rf $item_name
        else if test -f $item_name
            log.info "Deleting file $item_name"
            $rm_command -f $item_name
        else
            log.info "$item_name doesn't need to be deleted"
        end
    end

    function ___usage
        set -l help_args '-a' 'Cleanup files and reinstall Spacevim [**UNSTABLE**]'
        set -a help_args '-f' "A|all|Perform all actions (Clean update)|true"
        set -a help_args '-f' "N|clean-nvim|Clean NVIM related files|$CLEAN_NVIM"
        set -a help_args '-f' "V|clean-vim|Clean VIM Related files|$CLEAN_VIM"
        set -a help_args '-f' "C|clean-cache|Clean all cache files|$CLEAN_CACHE"
        set -a help_args '-f' "S|clean-spacevim|Clean Spacevim related files|$CLEAN_SPACEVIM"
        set -a help_args '-f' "s|configure-spacevim|Ensure NVim is configured|$CONFIGURE_NVIM"
        set -a help_args '-f' "c|configure-vim|Ensure VIM is configured|$CONFIGURE_VIM"
        set -a help_args '-f' "n|configure-nvim|Ensure NVIM is configured|$CONFIGURE_NVIM"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case A 'all'
                set CLEAN_NVIM 'true'
                set CLEAN_VIM 'true'
                set CLEAN_CACHE 'true'
                set CLEAN_SPACEVIM 'true'
                set CONFIGURE_NVIM 'true'
                set CONFIGURE_VIM 'true'
                set CONFIGURE_SPACEVIM 'true'
            case N 'clean-nvim'
                set CLEAN_NVIM 'true'
            case V 'clean-vim'
                set CLEAN_VIM 'true'
            case C 'clean-cache'
                set CLEAN_CACHE 'true'
            case S 'clean-spacevim'
                set CLEAN_SPACEVIM 'true'
            case s 'configure-spacevim'
                set CONFIGURE_SPACEVIM 'true'
            case n 'configure-spacevim'
                set CONFIGURE_NVIM 'true'
            case c 'configure-vim'
                set CONFIGURE_VIM 'true'
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET 'true'
            case v verbose
                set -x DEBUG 'true'
        end
    end

    log.debug "CONFIGURE_VIM      : $CONFIGURE_VIM"
    log.debug "CONFIGURE_NVIM     : $CONFIGURE_NVIM"
    log.debug "CONFIGURE_SPACEVIM : $CONFIGURE_SPACEVIM"
    log.debug "CLEAN_CACHE        : $CLEAN_CACHE"
    log.debug "CLEAN_NVIM         : $CLEAN_NVIM"
    log.debug "CLEAN_CACHE        : $CLEAN_CACHE"
    log.debug "CLEAN_VIM          : $CLEAN_VIM"

    if test "$CLEAN_VIM" = 'true'
        log.info 'Deleting Vim files'
        __vim_clean_files_delete "$HOME/.vim"
        if test "$CLEAN_CACHE" = 'true'
            __vim_clean_files_delete "$HOME/.cache/vimfiles"
        end
        TabNine::config
    end

    if test "$CLEAN_NVIM" = 'true'
        log.info 'Deleting NeoVim files'
        __vim_clean_files_delete "$NEOVIM_HOME"
        __vim_clean_files_delete "$HOME/.local/share/nvim"
        log.info 'Deleting CoC.nvim files'
        __vim_clean_files_delete "$SYSTEM_CONFIG_DIR/coc/extensions"
    end

    if test "$CLEAN_SPACEVIM" = 'true'
        log.info 'Deleting SpaceVim files'
        __vim_clean_files_delete "$HOME/.Spacevim.d"
        __vim_clean_files_delete "$HOME/.Spacevim"
        if test "$CLEAN_CACHE" = 'true'
            __vim_clean_files_delete "$HOME/.cache/SpaceVim"
        end
    end

    if test "$CONFIGURE_SPACEVIM" = 'true'
        log.info 'Linking custom config to default spacevim config'
        ln -fs "$SPACEVIM_INIT_PATH" "$HOME/.SpaceVim.d"

        log.info 'Re-linking SpaceVim for Neovim'
        ln -fs "$HOME/.SpaceVim" "$NEOVIM_HOME"

        log.info 'Running SpaceVim installer'
        installer.spacevim
    end

    if test "$CONFIGURE_NVIM" = 'true'
        if test -d "$PYTHON_VENV_PATH"
            log.info "Deleting python virtual environment $PYTHON_VENV_PATH"
            $rm_command -rf $PYTHON_VENV_PATH
        end

        __vim_create_venv "$PYTHON_VENV_PATH"
    end
end
