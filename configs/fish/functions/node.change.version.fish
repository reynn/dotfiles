function node.change.version -d "Get a version of Go or source the latest environment from Gimme"
    set -l node_version "$argv[1]"
    set -l script_url 'https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh'
    set -l existing_versions (fd -td -d1 . --base-directory $HOME/.nvm/versions/node | sort -ru)

    function __node_change_version_set_env
        set -l new_version $argv[1]
        set -l node_path "$HOME/.nvm/versions/node/$new_version"
        # set -xU GOROOT $node_path
        utils.path.replace $node_path/bin '3'
    end

    if test -n "$node_version"
        contains -- $node_version $existing_versions
        and __node_change_version_set_env $node_version
        or curl -sL $script_url | bash
    else
        set -l node_version (\
          string split ' ' $existing_versions |\
          fzf --select-1 --prompt 'Go version> ' --height 40%)
        log.info -m "Changing to node version $node_version"
        __node_change_version_set_env $node_version
    end
end
