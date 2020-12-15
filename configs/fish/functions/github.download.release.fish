#!/usr/bin/env fish

# This script will download pre-compiled binaries, such as those provided by Rust and Golang developers
# and setup an environment for them to be run from your console.
# ----------------------------------------------------------
# Directory is setup in the $base_directory (default $HOME/.bins) with subdirectories for envs and github.
# # Envs directory
# Contains symlinks to the currently active versions of binaries.
# # Github directory
# Contains downloaded assets from the GitHub releases and symlinks to the active version
# # Directory structure
# {BASE}/
#       /envs/
#       /envs/gh
#       /envs/exa
#       /envs/nvim
#       /github/neovim/neovim/
#                     /neovim/nightly/nvim-linux64.tar.gz
#                     /neovim/nightly/nvim-linux64/bin/nvim
#                     /neovim/nvim -> $PWD/nightly/nvim-linux64/bin/nvim
#       /github/ogham/exa/
#                    /exa/v0.9.0/exa-linux64-x86_64.tar.gz
#                    /exa/v0.9.0/exa-linux64-x86_64
#                    /exa/exa -> $PWD/v0.9.0/exa-linux64-x86_64

function github.download.release -d "Download a release from GitHub in the expected structure"
    ###########################################################
    # Functions
    ###########################################################
    function __versm_handle_asset -d 'Extract archive if necessary. link to envs path if executable'
        set -l asset ''
        set -l version_directory ''
        set -l bin_alias ''
        set -l bin_filter ''
        set -l env_dir ''

        getopts $argv | while read -l key value
            switch $key
                case a asset
                    set asset $value
                case e env
                    set env_dir $value
                case f filter
                    set bin_filter $value
                case d directory
                    set version_directory $value
                case b bin-alias
                    set bin_alias $value
            end
        end

        set -l asset_path (string split ':' $asset | head -1)
        set -l asset_type (string split ':' $asset | tail -1 | string trim)
        set -l ver_base_dir (dirname $version_directory)
        set -l asset_current_link "$ver_base_dir/$bin_alias"

        log.debug -m "handle_asset.asset               : $asset"
        log.debug -m "handle_asset.bin_filter          : $bin_filter"
        log.debug -m "handle_asset.version_directory   : $version_directory"
        log.debug -m "handle_asset.asset_path          : $asset_path"
        log.debug -m "handle_asset.asset_type          : $asset_type"
        log.debug -m "handle_asset.asset_current_link  : $asset_current_link"
        log.debug -m "handle_asset.ver_base_dir        : $ver_base_dir"
        log.debug -m "handle_asset.env_dir             : $env_dir"

        if test "$asset_path" = "$asset_type"
            log.error -m "handle_asset The provided asset isn't in the right format (call [file --mime-type {}] on the file path)"
            return 2
        end
        switch $asset_type
            case '*/x-mach-binary' '*/x-pie-executable' '*/x-executable'
                log.debug -m "handle_asset treating "(basename $asset_path)" as an executable"
                chmod +x $asset_path
                # if the expected link to current already exists delete it so we can create the new one
                __versm_create_symlink "$asset_path" "$asset_current_link"
                # if the $env_path isn't already a symlink we will create it
                __versm_create_symlink "$asset_current_link" "$env_dir/$bin_alias"
                return 0
            case 'application/zip*'
                if test -x (command -s unzip)
                    log.info -m "handle_asset Extracting $asset_path"
                    unzip -o "$asset_path" -d (dirname "$asset_path")
                    __versm_find_exec_after_extract "$version_directory" "$bin_filter" "$asset_path" "$bin_alias" "$env_dir"
                else
                    log.error -m 'handle_asset `unzip` is unavailable in the path'
                    return 2
                end
            case 'application/gzip*'
                if test -x (command -s tar)
                    log.info -m "handle_asset Extracting ($asset_path) to ($version_directory)"
                    tar xf "$asset_path" -C "$version_directory"
                    __versm_find_exec_after_extract "$version_directory" "$bin_filter" "$asset_path" "$bin_alias" "$env_dir"
                else
                    log.error -m 'handle_asset `tar` is unavailable in the path'
                    return 2
                end
            case 'inode/directory'
                return 3
        end
    end

    function __versm_create_symlink -d "Create a symlink, delete existing one"
        set -l src "$argv[1]"
        set -l dest "$argv[2]"
        log.info -m "create_symlink Linking $src -> $dest"
        ln -fs $src $dest
    end

    function __versm_find_exec_after_extract -d 'Find executables and send appropriate ones to __versm_handle_asset'
        set -l directory "$argv[1]"
        set -l filter "$argv[2]"
        set -l asset_name "$argv[3]"
        set -l alias "$argv[4]"
        set -l env_dir "$argv[5]"

        log.debug -m "find_exec_after_extract.directory  : $directory"
        log.debug -m "find_exec_after_extract.filter     : $filter"
        log.debug -m "find_exec_after_extract.alias      : $alias"
        log.debug -m "find_exec_after_extract.asset_name : $asset_name"
        log.debug -m "find_exec_after_extract.env_dir    : $env_dir"
        log.debug -m "find_exec_after_extract.Calling `find` for [$directory]"

        set -l executables (find "$directory" -type f -executable 2>/dev/null; or find "$directory" -type f -perm '+111')
        for executable in $executables
            log.debug -m "matching [$filter] against file [$executable]"
            if string match -q -r $filter $executable
                log.info -m "find_exec_after_extract.Discovered executable [$executable]"
                __versm_handle_asset -a (file --mime-type $executable) -d "$directory" -b "$alias" -e "$env_dir" -f "$filter"
                if test $status -eq 0
                    break
                end
            end
        end
    end

    function __versm_set_env -d 'Setup the environment for the shell'
        contains -- $argv[1] $fish_user_paths
        and log.info -m 'Environment ready'
        or set -Up fish_user_paths $argv[1]
    end

    function __versm_get_asset_data -d 'Use find to locate executable files and run file --mime-type on them'
        set -l directory $argv[1]
        find $directory -maxdepth 1 -type f -exec file --mime-type {} \;
    end

    function __versm_default_github_pattern -d 'set a default pattern for the current OS'
        echo '*'(string lower (uname))'*'
    end

    function __versm_init -d 'Download the GitHub CLI if not already installed'
        log.info -m 'Please install the GitHub CLI or ensure it is executable and in the PATH or fish_user_paths'
        set -l cli_base_dir "$base_directory/github/cli/cli"
        set -l directory_exists (test -d "$cli_base_dir"; and echo 'true'; or echo 'false')
        log.info -m "directory_exists: $directory_exists"
        if test "$directory_exists" != 'true'
            log.info -m 'Need to download from scratch'
            # return 2
        end
        set -l cli_symlink "$base_directory/github/cli/cli/gh"
        set -l symlink_exists (test -L "$cli_symlink"; and echo 'true'; or echo 'false')
        log.info -m "symlink_exists: $symlink_exists"
        if test "$symlink_exists" = 'true'
            # check that symlink is valid
            # return 0
        end
        log.error -m 'Not yet implemented.'
        return 2
    end

    function ___usage
        set -a help_args '-f' 'h|help|Print this help message'
        set -a help_args '-f' 'e|env|Set path if necessary'
        set -a help_args '-f' 'r|repo|The name of the repo to get release from [repo-owner/repo-name]'
        set -a help_args '-f' 'p|pattern|File pattern for downloading from release asset list'
        set -a help_args '-f' 'a|alias|How to call the release after downloaded if different from the repo name'
        set -a help_args '-f' 'd|base-dir|Where to store the data for this script), default(\$HOME/.bins'
        set -a help_args '-f' 'f|filter|Filter for the name of the binary if not found automatically'
        set -a help_args '-f' 'P|pre-release|Allow pre-releases to be pulled as well as stable'
        set -a help_args '-f' 's|show|Show list of versions for the repo'
        set -a help_args '-f' 'S|show-assets|Shows assets for a specific version"'
        switch "$system_platform"
            case 'linux'
                log.debug -m 'Adding examples for Linux'
                set -a help_args '-e' " -r 'argoproj/argo-cd'             -p '*linux-amd64'                     -a 'argocd'"
                set -a help_args '-e' " -r 'denisidoro/navi'              -p '*x86_64-unknown-linux-musl.tar.gz'"
                set -a help_args '-e' " -r 'derailed/k9s'                 -p '*Linux_x86_64.tar.gz'"
                set -a help_args '-e' " -r 'digitalocean/doctl'           -p '*linux-amd64.tar.gz'"
                set -a help_args '-e' " -r 'extrawurst/gitui'"
                set -a help_args '-e' " -r 'jesseduffield/lazygit'        -p '*Linux_x86_64.tar.gz'             -a 'lg'"
                set -a help_args '-e' " -r 'mikefarah/yq'                 -p 'yq_linux_amd64'"
                set -a help_args '-e' " -r 'neovim/neovim'                -p '*linux64.tar.gz'                  -a 'nvim'         -P"
                set -a help_args '-e' " -r 'ogham/exa'"
                set -a help_args '-e' " -r 'ovh/cds'                      -p 'cds-engine-linux-amd64'           -a 'cds-engine'   -f 'cds-engine-linux-amd64'"
                set -a help_args '-e' " -r 'ovh/cds'                      -p 'cdsctl-linux-amd64-nokeychain'    -a 'cdsctl'       -f 'cdsctl-linux-amd64-nokeychain'"
                set -a help_args '-e' " -r 'Powershell/Powershell'        -p '*linux-x64.tar.gz'                -a 'pwsh'         -f '/pwsh\$'"
                set -a help_args '-e' " -r 'rust-analyzer/rust-analyzer'  -p '*-linux'                          -P"
                set -a help_args '-e' " -r 'sharkdp/fd'                   -p '*x86_64-unknown-linux-gnu.tar.gz'"
                set -a help_args '-e' " -r 'starship/starship'            -p '*linux-gnu.tar.gz'"
                set -a help_args '-e' " -r 'stedolan/jq'                  -p 'jq-linux64'                       -a 'jq'"
            case 'darwin'
                log.debug -m 'Adding examples for Darwin'
                set -a help_args '-e' " -r 'argoproj/argo-cd'             -p '*darwin*'                 -a 'argocd'"
                set -a help_args '-e' " -r 'denisidoro/navi'              -p '*osx*'"
                set -a help_args '-e' " -r 'derailed/k9s'                 -p '*Darwin*'"
                set -a help_args '-e' " -r 'digitalocean/doctl'           -p '*darwin*'"
                set -a help_args '-e' " -r 'extrawurst/gitui'"
                set -a help_args '-e' " -r 'jesseduffield/lazygit'        -p '*Darwin*'                 -a 'lg'"
                set -a help_args '-e' " -r 'mikefarah/yq'                 -p '*darwin*'"
                set -a help_args '-e' " -r 'neovim/neovim'                -p '*macos.tar.gz'            -a 'nvim'         -P"
                set -a help_args '-e' " -r 'ogham/exa'                    -p '*macos*'"
                set -a help_args '-e' " -r 'ovh/cds'                      -p 'cds-engine-darwin-amd64'  -a 'cds-engine'   -f 'cds-engine-darwin-amd64'"
                set -a help_args '-e' " -r 'ovh/cds'                      -p 'cdsctl-darwin-amd64'      -a 'cdsctl'       -f 'cdsctl-darwin-amd64'"
                set -a help_args '-e' " -r 'Powershell/Powershell'        -p '*-osx-x64.tar.gz'         -a 'pwsh'         -f '/pwsh\$'"
                set -a help_args '-e' " -r 'rust-analyzer/rust-analyzer'  -p 'rust-analyzer-mac'        -P"
                set -a help_args '-e' " -r 'sharkdp/fd'                   -p '*-x86_64-apple*'"
                set -a help_args '-e' " -r 'starship/starship'            -p '*-x86_64-apple*'"
                set -a help_args '-e' " -r 'stedolan/jq'                  -p '*-osx-amd64'              -a 'jq'"
            case '*'
                log.error -m "Platform [$system_platform] doesn't have available examples"
        end
        set -a help_args '-c' "2|Invalid or missing configuration"
        set -a help_args '-c' "3|Github/Validation error"
        show.help $help_args
    end

    function __versm -d 'Main logic to get assets for a specific repository'
        if test -e (command -s fzf)
            set latest_release_version (gh release --repo $repo list | grep -i "$release_filter" | awk '{print $3}' FS='\t' | fzf --select-1 --exit-0)
        else
            set latest_release_version (gh release --repo $repo list | grep -i "$release_filter" | awk '{print $3}' FS='\t')
        end
        set latest_release_version (string trim -r -l "$latest_release_version")

        if test "$latest_release_version" = ''
            log.error -m 'Failed to get the latest release from GitHub'
            return 2
        end

        set -lx version_directory "$base_directory/github/$repo/$latest_release_version"

        log.debug -m "Base directory           : $base_directory"
        log.debug -m "Repo                     : $repo"
        log.debug -m "Latest version           : $latest_release_version"
        log.debug -m "Latest version directory : $version_directory"

        mkdir -p "$version_directory"
        mkdir -p "$bins_env_path"

        if test -z $pattern
            log.info -m "Downloading assets from GitHub to $version_directory"
            gh release --repo $repo download $latest_release_version --dir $version_directory
        else
            log.info -m "Downloading assets from GitHub to $version_directory with pattern $pattern"
            gh release --repo $repo download $latest_release_version --dir $version_directory --pattern $pattern
        end

        log.debug -m "Getting assets from $version_directory"
        set -l downloaded_assets (__versm_get_asset_data $version_directory)

        if test -z "$downloaded_assets"
            log.error -m 'No assets downloaded from GitHub, try altering the pattern'
            gh release --repo $repo view $latest_release_version
            return 3
        end

        log.debug -m "Found "(count $downloaded_assets)" assets"
        log.debug -m "Downloaded assets [$downloaded_assets]"

        for asset in $downloaded_assets
            __versm_handle_asset -a "$asset" -d "$version_directory" -b "$bin_alias" -e "$bins_env_path" -f "$bin_filter"
            if test "$cleanup_assets" = 'true'
                set -l asset_name (string split ':' $asset)[1]
                log.info -m "Deleting asset $asset_name"
                rm -fv $asset_name
            end
        end
    end

    function __versm_get_system_defaults -d 'Gets a set of default repositories to fetch'
        set -l repositories
        switch "$system_platform"
            case 'darwin'
                set -a repositories " -r 'argoproj/argo-cd'             -p '*darwin*'                 -a 'argocd'"
                set -a repositories " -r 'denisidoro/navi'              -p '*osx*'"
                set -a repositories " -r 'derailed/k9s'                 -p '*Darwin*'"
                set -a repositories " -r 'digitalocean/doctl'           -p '*darwin*'"
                set -a repositories " -r 'extrawurst/gitui'"
                set -a repositories " -r 'jesseduffield/lazygit'        -p '*Darwin*'                 -a 'lg'"
                set -a repositories " -r 'mikefarah/yq'                 -p '*darwin*'"
                set -a repositories " -r 'neovim/neovim'                -p '*macos.tar.gz'            -a 'nvim'         -P"
                set -a repositories " -r 'ogham/exa'                    -p '*macos*'"
                set -a repositories " -r 'ovh/cds'                      -p 'cds-engine-darwin-amd64'  -a 'cds-engine'   -f 'cds-engine-darwin-amd64'"
                set -a repositories " -r 'ovh/cds'                      -p 'cdsctl-darwin-amd64'      -a 'cdsctl'       -f 'cdsctl-darwin-amd64'"
                set -a repositories " -r 'Powershell/Powershell'        -p '*-osx-x64.tar.gz'         -a 'pwsh'         -f '/pwsh\$'"
                set -a repositories " -r 'rust-analyzer/rust-analyzer'  -p 'rust-analyzer-mac'        -P"
                set -a repositories " -r 'sharkdp/fd'                   -p '*-x86_64-apple*'"
                set -a repositories " -r 'starship/starship'            -p '*-x86_64-apple*'"
                set -a repositories " -r 'stedolan/jq'                  -p '*-osx-amd64'              -a 'jq'"
            case 'linux'
                set -a repositories " -r 'argoproj/argo-cd'             -p '*linux-amd64'                     -a 'argocd'"
                set -a repositories " -r 'denisidoro/navi'              -p '*x86_64-unknown-linux-musl.tar.gz'"
                set -a repositories " -r 'derailed/k9s'                 -p '*Linux_x86_64.tar.gz'"
                set -a repositories " -r 'digitalocean/doctl'           -p '*linux-amd64.tar.gz'"
                set -a repositories " -r 'extrawurst/gitui'"
                set -a repositories " -r 'jesseduffield/lazygit'        -p '*Linux_x86_64.tar.gz'             -a 'lg'"
                set -a repositories " -r 'mikefarah/yq'                 -p 'yq_linux_amd64'"
                set -a repositories " -r 'neovim/neovim'                -p '*linux64.tar.gz'                  -a 'nvim'         -P"
                set -a repositories " -r 'ogham/exa'"
                set -a repositories " -r 'ovh/cds'                      -p 'cds-engine-linux-amd64'           -a 'cds-engine'   -f 'cds-engine-linux-amd64'"
                set -a repositories " -r 'ovh/cds'                      -p 'cdsctl-linux-amd64-nokeychain'    -a 'cdsctl'       -f 'cdsctl-linux-amd64-nokeychain'"
                set -a repositories " -r 'Powershell/Powershell'        -p '*linux-x64.tar.gz'                -a 'pwsh'         -f '/pwsh\$'"
                set -a repositories " -r 'rust-analyzer/rust-analyzer'  -p '*-linux'                          -P"
                set -a repositories " -r 'sharkdp/fd'                   -p '*x86_64-unknown-linux-gnu.tar.gz'"
                set -a repositories " -r 'starship/starship'            -p '*linux-gnu.tar.gz'"
                set -a repositories " -r 'stedolan/jq'                  -p 'jq-linux64'                       -a 'jq'"
        end
        echo $repositories
    end

    ###########################################################
    # Variables
    ###########################################################
    set -lx system_platform (uname | string lower)
    set -lx base_directory "$HOME/.bins"
    set -lx repo ''
    set -lx repo_name ''
    set -lx repo_owner ''
    set -lx pattern (__versm_default_github_pattern)
    set -lx bin_alias ''
    set -lx bin_filter ''
    set -lx release_filter 'latest'
    set -lx set_env_only 'false'
    set -lx show_versions 'false'
    set -lx show_versions_only 'false'
    set -lx show_assets_only 'false'
    set -lx cleanup_assets 'false'

    getopts $argv | while read -l key value
        switch $key
            case h help
                ___usage
                return 0
            case D defaults
                __versm_get_system_defaults
                return 0
            case e env
                set set_env_only 'true'
            case s show
                set show_versions 'true'
                set show_versions_only 'true'
            case S show-assets
                set show_versions 'true'
                set show_assets_only 'true'
            case r repo
                set repo $value
                set repo_owner (string split '/' $value | head -1)
                set repo_name (string split '/' $value | tail -1)
            case p pattern
                set pattern $value
            case c clean
                set cleanup_assets 'true'
            case a alias
                set bin_alias $value
            case d base-dir
                set base_directory $value
            case f filter
                set bin_filter $value
            case P pre-release
                set release_filter 'pre-release'
            case v verbose
                set -x DEBUG 'true'
        end
    end

    # Check for the CLI early, call an init function if not available
    set -lx gh_cli_path (command -s gh)
    if test -z "$gh_cli_path"
        __versm_init
        if test $status -gt 0
            log.error -m 'Failed to initialize the GitHub CLI'
            return 2
        end
    end

    if test -z $bin_alias
        set bin_alias $repo_name
    end

    if test -z $bin_filter
        set bin_filter "/$bin_alias\$"
    end

    set bins_env_path "$base_directory/envs"
    set -l show_versions_result ''
    if test $set_env_only = 'true'
        __versm_set_env $bins_env_path
        return 0
    end
    if test $show_versions = 'true'
        set show_versions_result (gh release --repo $repo list | awk '{print $3}' FS='\t' | fzf)
        if test $show_versions_only = 'true'
            return 0
        end
    end
    if test $show_assets_only = 'true'
        gh release --repo $repo view $show_versions_result
        return 0
    end

    log.debug -m "global.base_directory : $base_directory"
    log.debug -m "global.repo           : $repo"
    log.debug -m "global.repo_name      : $repo_name"
    log.debug -m "global.repo_owner     : $repo_owner"
    log.debug -m "global.pattern        : $pattern"
    log.debug -m "global.release_filter : $release_filter"
    log.debug -m "global.bin_alias      : $bin_alias"
    log.debug -m "global.bin_filter     : $bin_filter"
    log.debug -m "global.bins_env_path  : $bins_env_path"

    if test -z $repo_name || test -z $repo_owner
        log.error -m 'Please provide a <repo_name> and a <repo_owner>'
        return 2
    end

    ###########################################################
    # Main logic
    ###########################################################
    __versm

end
