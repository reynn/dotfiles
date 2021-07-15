#!/usr/bin/env fish

function nvim.update -d 'Cleanup files and reinstall Spacevim'
    set -x SYSTEM_CONFIG_DIR (set -q XDG_CONFIG_HOME; and echo "$XDG_CONFIG_HOME"; or echo "$HOME/.config")
    set -x SYSTEM_CACHE_DIR (set -q XDG_CACHE_HOME; and echo "$XDG_CACHE_HOME"; or echo "$HOME/.cache")
    set -x NEOVIM_HOME "$SYSTEM_CONFIG_DIR/nvim"
    set -x NEOVIM_CACHE "$SYSTEM_CACHE_DIR/nvim"
    set -x PYTHON_VENV_PATH "$NEOVIM_CACHE/py3-env"
    set -x rm_command (command -s rm)

    set -x CLEAN_CACHE false
    set -x CLEAN_NVIM false
    set -x CONFIGURE_NVIM false

    function ___nvim_create_venv
        set -l venv_path "$argv[1]"
        log debug "Creating python virtual environment $venv_path"
        mkdir -p (dirname $venv_path)
        python3 -m venv $venv_path
        source "$venv_path/bin/activate.fish"
        python -m pip install --quiet -U neovim pip
        deactivate
    end

    function ___nvim_clean_files_delete
        # Get a handle to the builtin rm command instead of an alias
        set -l item_name "$argv[1]"
        if test -d $item_name
            log "Deleting directory $item_name"
            $rm_command -rf $item_name
        else if test -f $item_name
            log "Deleting file $item_name"
            $rm_command -f $item_name
        else
            log "$item_name doesn't need to be deleted"
        end
    end

    function ___usage
        set -l help_args -a 'Cleanup files and reinstall Spacevim [**UNSTABLE**]'
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

    log debug "CLEAN_CACHE        : $CLEAN_CACHE"
    log debug "CLEAN_NVIM         : $CLEAN_NVIM"
    log debug "CONFIGURE_NVIM     : $CONFIGURE_NVIM"

    if test "$CLEAN_NVIM" = true
        log debug 'Deleting NeoVim files'
        ___nvim_clean_files_delete "$NEOVIM_HOME"
        ___nvim_clean_files_delete "$NEOVIM_CACHE"
        ___nvim_clean_files_delete "$HOME/.local/share/nvim/site/pack/packer"
        ___nvim_clean_files_delete "$HOME/.local/share/nvim"

        if test -d "$PYTHON_VENV_PATH"
            log debug "Deleting python virtual environment $PYTHON_VENV_PATH"
            $rm_command -rf $PYTHON_VENV_PATH
        end

        set -e NVIM_PYTHON3_HOME
    end

    if test "$CONFIGURE_NVIM" = true
        ___nvim_create_venv "$PYTHON_VENV_PATH"
        if not set -q DFP
            log error 'Dotfiles Path [$DFP] is not set or not exported'
            return 3
        end

        log debug "Symlinking nvim configuration to $NEOVIM_HOME"
        set -Ux NVIM_PYTHON3_HOME "$PYTHON_VENV_PATH"
        ln -sf "$DFP/configs/nvim/" "$SYSTEM_CONFIG_DIR"
    end
end
