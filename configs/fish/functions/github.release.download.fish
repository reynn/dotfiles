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

function github.release.download -d "Download a release from GitHub in the expected structure"

    ###########################################################
    # Functions
    ###########################################################

    function __versm -d 'Main logic to get assets for a specific repository'
        if test -z "$latest_release_version"
            if command.is_available -c sk
                set latest_release_version (gh release --repo $repo list | grep -i "$release_filter" | awk '{print $3}' FS='\t' | sk --select-1 --exit-0)
            else
                set latest_release_version (gh release --repo $repo list | grep -i "$release_filter" | awk '{print $3}' FS='\t' | head -n 1)
            end
        end

        if test "$latest_release_version" = ''
            __log error 'Failed to get the latest release from GitHub'
            return 1
        end

        set -x repo_directory "$base_directory/github/$repo"
        set -x installed_versions (fd -td -d1 . $repo_directory)

        if test "$delete_only" = true
            set -l versions_to_delete (echo $installed_versions | sk --select-1 --exit-0)
            set -l user_answer (read -P "Are you sure you want to delete "(count $versions_to_delete)" of $repo? (y/n)  ")
            if test "$user_answer" = y
                for repo_version in $versions_to_delete
                    __log info "Deleting $repo_version"
                    rm -rf $repo_directory/$repo_version
                end
                if test "$versions_to_delete" = "$installed_versions"
                    __log info "No more versions installed, removing links"
                    rm -rf $repo_directory
                    rm -f $base_directory/envs/$bin_alias
                end
            end
            return 0
        end

        set -x version_directory "$repo_directory/$latest_release_version"

        __log debug "Base directory           : $base_directory"
        __log debug "Repo                     : $repo"
        __log debug "Latest version           : $latest_release_version"
        __log debug "Latest version directory : $version_directory"

        mkdir -p "$version_directory"; and mkdir -p "$bins_env_path"

        set download_status 0

        if test -z $pattern
            __log "Downloading assets from GitHub to $version_directory"
            gh release --repo $repo download $latest_release_version --dir $version_directory
            set download_status $status
        else
            __log "Downloading assets from GitHub to $version_directory with pattern $pattern"
            gh release --repo $repo download $latest_release_version --dir $version_directory --pattern $pattern
            set download_status $status
        end

        if test $download_status != 0
            __log "Latest version already downloaded 🐟"
            return 0
        end

        __log debug "Getting assets from $version_directory"
        set -l downloaded_assets (__versm_get_asset_data $version_directory)

        if test -z "$downloaded_assets"
            __log error 'No assets downloaded from GitHub, try altering the pattern'
            gh release --repo $repo view $latest_release_version
            return 3
        end

        __log debug "Found "(count $downloaded_assets)" assets"
        __log debug "Downloaded assets [$downloaded_assets]"

        for asset in $downloaded_assets
            __versm_handle_asset -a "$asset" -d "$version_directory" -b "$bin_alias" -e "$bins_env_path" -f "$bin_filter"
            if test "$cleanup_assets" = true
                set -l asset_name (string split ':' $asset)[1]
                __log "Deleting asset $asset_name"
                rm -fv $asset_name
            end
        end
    end

    function __versm_handle_asset -d 'Extract archive if necessary. link to envs path if executable'
        set -x asset ''
        set -x version_directory ''
        set -x bin_alias ''
        set -x bin_filter ''
        set -x env_dir ''

        getopts $argv | while read -l key value
            switch $key
                case a asset
                    set -x asset "$value"
                case e env
                    set -x env_dir "$value"
                case f filter
                    set -x bin_filter "$value"
                case d directory
                    set -x version_directory "$value"
                case b bin-alias
                    set -x bin_alias "$value"
            end
        end

        set -x asset_path (string split ':' $asset | head -1)
        set -x asset_type (string split ':' $asset | tail -1 | string trim)
        set -x ver_base_dir (dirname $version_directory)
        set -x asset_current_link "$ver_base_dir/$bin_alias"

        __log debug "handle_asset.asset               : $asset"
        __log debug "handle_asset.bin_filter          : $bin_filter"
        __log debug "handle_asset.version_directory   : $version_directory"
        __log debug "handle_asset.asset_path          : $asset_path"
        __log debug "handle_asset.asset_type          : $asset_type"
        __log debug "handle_asset.asset_current_link  : $asset_current_link"
        __log debug "handle_asset.ver_base_dir        : $ver_base_dir"
        __log debug "handle_asset.env_dir             : $env_dir"

        if test "$asset_path" = "$asset_type"
            __log error "handle_asset The provided asset isn't in the right format (call [file --mime-type {}] on the file path)"
            return 1
        end

        switch "$asset_type"
            case '*/x-mach-binary' '*/x-pie-executable' '*/x-executable'
                __log debug "handle_asset treating "(basename $asset_path)" as an executable"
                chmod +x $asset_path
                # if the expected link to current already exists delete it so we can create the new one
                __versm_create_symlink "$asset_path" "$asset_current_link"
                # if the $env_path isn't already a symlink we will create it
                __versm_create_symlink "$asset_current_link" "$env_dir/$bin_alias"
                return 0
            case application/zip
                if command.is_available -c unzip
                    __log "handle_asset Extracting $asset_path"
                    unzip -o "$asset_path" -d (dirname "$asset_path")
                    __versm_find_exec_after_extract "$version_directory" "$bin_filter" "$asset_path" "$bin_alias" "$env_dir"
                else
                    __log error 'handle_asset `unzip` is unavailable in the path'
                    return 1
                end
            case 'application/gzip*'
                if command.is_available -c tar
                    __log "handle_asset Extracting ($asset_path) to ($version_directory)"
                    tar xf "$asset_path" -C "$version_directory"
                    __versm_find_exec_after_extract "$version_directory" "$bin_filter" "$asset_path" "$bin_alias" "$env_dir"
                else
                    __log error 'handle_asset `tar` is unavailable in the path'
                    return 1
                end
            case inode/directory
                return 3
        end
    end

    function __versm_create_symlink -d "Create a symlink, delete existing one"
        set -l src "$argv[1]"
        set -l dest "$argv[2]"
        __log "create_symlink Linking [$src] -> [$dest]"
        ln -fs $src $dest
    end

    function __versm_find_exec_after_extract -d 'Find executables and send appropriate ones to __versm_handle_asset'
        set -x directory "$argv[1]"
        set -x filter "$argv[2]"
        set -x asset_name "$argv[3]"
        set -x alias "$argv[4]"
        set -x env_dir "$argv[5]"

        __log debug "find_exec_after_extract.directory  : $directory"
        __log debug "find_exec_after_extract.filter     : $filter"
        __log debug "find_exec_after_extract.alias      : $alias"
        __log debug "find_exec_after_extract.asset_name : $asset_name"
        __log debug "find_exec_after_extract.env_dir    : $env_dir"
        __log debug "find_exec_after_extract.Calling `find` for [$directory]"

        set -l executables (find "$directory" -type f -executable 2>/dev/null; or find "$directory" -type f -perm '+111')
        for executable in $executables
            __log debug "matching [$filter] against file [$executable]"
            if string match -q -r $filter $executable
                __log "find_exec_after_extract.Discovered executable [$executable]"
                __versm_handle_asset -a (file --mime-type $executable) -d "$directory" -b "$alias" -e "$env_dir" -f "$filter"
                if test $status -eq 0
                    break
                end
            end
        end
    end

    function __versm_set_env -d 'Setup the environment for the shell'
        contains -- $argv[1] $fish_user_paths
        and __log 'Environment ready'
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
        __log 'Please install the GitHub CLI or ensure it is executable and in the PATH or fish_user_paths'
        set -l cli_base_dir "$base_directory/github/cli/cli"
        set -l directory_exists (test -d "$cli_base_dir"; and echo 'true'; or echo 'false')
        __log "directory_exists: $directory_exists"
        if test "$directory_exists" != true
            __log 'Need to download from scratch'
            # return 1
        end
        set -l cli_symlink "$base_directory/github/cli/cli/gh"
        set -l symlink_exists (test -L "$cli_symlink"; and echo 'true'; or echo 'false')
        __log "symlink_exists: $symlink_exists"
        if test "$symlink_exists" = true
            # check that symlink is valid
            # return 0
        end
        __log error 'Not yet implemented.'
        return 1
    end

    function ___usage
        set -a help_args -f 'e|env|Set path if necessary'
        set -a help_args -f '|delete|Delete a release either all or just a specific version|$delete_only'
        set -a help_args -f 'r|repo|The name of the repo to get release from [repo-owner/repo-name]'
        set -a help_args -f 'p|pattern|File pattern for downloading from release asset list'
        set -a help_args -f 'a|alias|How to call the release after downloaded if different from the repo name'
        set -a help_args -f 'd|base-dir|Where to store the data for this script), default(\$HOME/.bins)'
        set -a help_args -f 'f|filter|Filter for the name of the binary if not found automatically'
        set -a help_args -f 'P|pre-release|Allow pre-releases to be pulled as well as stable'
        set -a help_args -f 's|show|Show list of versions for the repo'
        set -a help_args -f 'S|show-assets|Shows assets for a specific version"'
        switch "$system_platform"
            case linux
                __log debug 'Adding examples for Linux'
                set -a help_args -e " -r argoproj/argo-cd -p argocd-linux-amd64 -a argocd"
                set -a help_args -e " -r argoproj/argo-workflows -p argo-linux-amd64 -a argo"
                set -a help_args -e " -r denisidoro/navi -p '*x86_64-unknown-linux-musl*'"
                set -a help_args -e " -r derailed/k9s -p '*Linux_x86_64*'"
                set -a help_args -e " -r digitalocean/doctl -p '*linux-amd64*'"
                set -a help_args -e " -r extrawurst/gitui"
                set -a help_args -e " -r jesseduffield/lazygit -p '*Linux_x86_64*' -a lg"
                set -a help_args -e " -r mikefarah/yq -p yq_linux_amd64"
                set -a help_args -e " -r neovim/neovim -p '*linux64.tar.gz' -a nvim -P"
                set -a help_args -e " -r ogham/exa"
                set -a help_args -e " -r ovh/cds -p cds-engine-linux-amd64 -a cds-engine -f cds-engine-linux-amd64"
                set -a help_args -e " -r ovh/cds -p cdsctl-linux-amd64-nokeychain -a cdsctl -f cdsctl-linux-amd64-nokeychain"
                set -a help_args -e " -r Powershell/Powershell -p '*linux-x64.tar.gz' -a pwsh -f '/pwsh\$'"
                set -a help_args -e " -r rust-analyzer/rust-analyzer -p '*-linux' -P"
                set -a help_args -e " -r sharkdp/fd -p '*x86_64-unknown-linux-gnu.tar.gz'"
                set -a help_args -e " -r starship/starship -p '*linux-gnu.tar.gz'"
                set -a help_args -e " -r stedolan/jq -p jq-linux64 -a jq"
            case darwin
                __log debug 'Adding examples for Darwin'
                set -a help_args -e " -r argoproj/argo-cd -p argocd-darwin-amd64 -a argocd"
                set -a help_args -e " -r argoproj/argo-workflows -p argo-darwin-amd64 -a argo"
                set -a help_args -e " -r denisidoro/navi -p '*x86_64-apple*'"
                set -a help_args -e " -r derailed/k9s -p '*Darwin_x86_64*'"
                set -a help_args -e " -r digitalocean/doctl -p '*darwin-amd64*'"
                set -a help_args -e " -r extrawurst/gitui"
                set -a help_args -e " -r jesseduffield/lazygit -p '*Darwin_x86_64*' -a lg"
                set -a help_args -e " -r mikefarah/yq -p '*darwin*'"
                set -a help_args -e " -r neovim/neovim -p '*macos.tar.gz' -a nvim -P"
                set -a help_args -e " -r ogham/exa -p '*macos*'"
                set -a help_args -e " -r ovh/cds -p cds-engine-darwin-amd64 -a cds-engine -f cds-engine-darwin-amd64"
                set -a help_args -e " -r ovh/cds -p cdsctl-darwin-amd64 -a cdsctl -f cdsctl-darwin-amd64"
                set -a help_args -e " -r Powershell/Powershell -p '*-osx-x64.tar.gz' -a pwsh -f '/pwsh\$'"
                set -a help_args -e " -r rust-analyzer/rust-analyzer -p '*x86_64-apple*' -P"
                set -a help_args -e " -r sharkdp/fd -p '*-x86_64-apple*'"
                set -a help_args -e " -r starship/starship -p '*-x86_64-apple*'"
                set -a help_args -e " -r stedolan/jq -p '*-osx-amd64' -a jq"
            case '*'
                __log error "Platform [$system_platform] doesn't have available examples"
        end
        set -a help_args -c "2|Invalid or missing configuration"
        set -a help_args -c "3|Github/Validation error"
        set -a help_args -c "4|No binary found"
        __dotfiles_help $help_args
    end

    function __versm_get_system_defaults -d 'Gets a set of default repositories to fetch'
        set -l repositories
        switch "$system_platform"
            case darwin
                set -a repositories " -r 'denisidoro/navi' -p '*osx*'"
                set -a repositories " -r 'digitalocean/doctl' -p '*darwin*'"
                set -a repositories " -r 'extrawurst/gitui'"
                set -a repositories " -r 'jesseduffield/lazygit' -p '*Darwin*'  -a 'lg'"
                set -a repositories " -r 'mikefarah/yq' -p '*darwin*'"
                set -a repositories " -r 'neovim/neovim' -p '*macos.tar.gz' -a 'nvim'         -P"
                set -a repositories " -r 'ogham/exa' -p '*macos*'"
                set -a repositories " -r 'rust-analyzer/rust-analyzer' -p 'rust-analyzer-mac'        -P"
                set -a repositories " -r 'sharkdp/fd' -p '*-x86_64-apple*'"
                set -a repositories " -r 'starship/starship' -p '*-x86_64-apple*'"
                set -a repositories " -r 'stedolan/jq' -p '*-osx-amd64' -a 'jq'"
            case linux
                set -a repositories " -r 'denisidoro/navi' -p '*x86_64-unknown-linux-musl.tar.gz'"
                set -a repositories " -r 'digitalocean/doctl' -p '*linux-amd64.tar.gz'"
                set -a repositories " -r 'extrawurst/gitui'"
                set -a repositories " -r 'jesseduffield/lazygit' -p '*Linux_x86_64.tar.gz' -a 'lg'"
                set -a repositories " -r 'mikefarah/yq' -p 'yq_linux_amd64'"
                set -a repositories " -r 'neovim/neovim' -p '*linux64.tar.gz' -a 'nvim'         -P"
                set -a repositories " -r 'ogham/exa'"
                set -a repositories " -r 'rust-analyzer/rust-analyzer' -p '*-linux'                          -P"
                set -a repositories " -r 'sharkdp/fd' -p '*x86_64-unknown-linux-gnu.tar.gz'"
                set -a repositories " -r 'starship/starship' -p '*linux-gnu.tar.gz'"
                set -a repositories " -r 'stedolan/jq' -p 'jq-linux64' -a 'jq'"
        end

        for repo in $repositories
            __log debug "Setting up [$repo]"
            eval "github.release.download$repo"
        end
    end

    ###########################################################
    # Variables
    ###########################################################
    set -x system_platform (uname | string lower)
    set -x base_directory "$HOME/.bins"
    set -x repo ''
    set -x repo_name ''
    set -x repo_owner ''
    set -x pattern (__versm_default_github_pattern)
    set -x bin_alias ''
    set -x bin_filter ''
    set -x release_filter latest
    set -x set_env_only false
    set -x show_versions false
    set -x show_versions_only false
    set -x show_assets_only false
    set -x cleanup_assets false
    set -x delete_only false

    # Parse the option flags, fails without `getopts` package, if using dotfiles run `dotfiles.update -A`
    getopts $argv | while read -l key value
        switch $key
            case D defaults
                __versm_get_system_defaults
                return 0
            case delete
                set delete_only true
            case e env
                set set_env_only true
            case s show
                set show_versions true
                set show_versions_only true
            case S show-assets
                set show_versions true
                set show_assets_only true
            case r repo
                set -x repo "$value"
                set -l repo_split (string split '/' "$value")
                set -x repo_owner $repo_split[1]
                set -x repo_name $repo_split[2]
                set -l repo_name_split (string split '@' $repo_name)
                if string match -q "*@*" $repo_name
                    # set -e repo_name
                    set -x repo_name $repo_name_split[1]
                    set -x repo "$repo_owner/$repo_name"
                    set -x latest_release_version $repo_name_split[2]
                else
                    set -x repo_name $repo_name_split[1]
                end
            case p pattern
                set -x pattern "$value"
            case c clean
                set cleanup_assets true
            case a alias
                set -x bin_alias "$value"
            case d base-dir
                set -x base_directory "$value"
            case f filter
                set -x bin_filter "$value"
            case P pre-release
                set release_filter pre-release
            case U update
                set -l os (string lower (uname))
                github.release.download -r cli/cli -a gh -p "*_$os""_amd64.tar.gz"
                return 0
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

    # Check for the CLI early, call an init function if not available
    set -x gh_cli_path (command -s gh)
    if test -z "$gh_cli_path"
        __versm_init
        if test $status -gt 0
            __log error 'Failed to initialize the GitHub CLI'
            return 1
        end
    end

    if test -z $bin_alias
        set bin_alias $repo_name
    end

    if test -z $bin_filter
        set bin_filter "/$bin_alias\$"
    end

    set -x bins_env_path "$base_directory/envs"
    set -x show_versions_result ''

    if test $set_env_only = true
        __versm_set_env $bins_env_path
        return 0
    end

    if test $show_versions = true
        set show_versions_result (gh release --repo $repo list | awk '{print $3}' FS='\t' | sk)
        if test $show_versions_only = true
            return 0
        end
    end

    if test $show_assets_only = true
        gh release --repo $repo view $show_versions_result
        return 0
    end

    __log debug "global.base_directory : $base_directory"
    __log debug "global.repo           : $repo"
    __log debug "global.repo_name      : $repo_name"
    __log debug "global.repo_owner     : $repo_owner"
    set -q latest_release_version; and __log debug "global.latest_release_version  : $latest_release_version"
    __log debug "global.pattern        : $pattern"
    __log debug "global.release_filter : $release_filter"
    __log debug "global.bin_alias      : $bin_alias"
    __log debug "global.bin_filter     : $bin_filter"
    __log debug "global.bins_env_path  : $bins_env_path"

    if test -z $repo_name || test -z $repo_owner
        __log error 'Please provide a <repo_name> and a <repo_owner>'
        return 1
    end
    # return 0

    ###########################################################
    # Main logic
    ###########################################################
    __versm

end
