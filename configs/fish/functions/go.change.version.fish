function go.change.version -d "Get a version of Go or source the latest environment from Gimme"
    set -l go_version "$argv[1]"
    set -lx script_url 'https://raw.githubusercontent.com/travis-ci/gimme/master/gimme'
    set -lx existing_versions (fd -td -d1 . --base-directory $HOME/.gimme/versions | tr -d 'go' | sort -ru)

    function ___usage
        set -l versions (string join ', ' $existing_versions)
        set -l help_args '-a' "Change or install Golang versions, discovered versions [$versions]"
        show.help $help_args
    end

    function __execute_gimme
        if test -z "$argv"
            echo "curl -sL $script_url | bash"
        else
            echo "curl -sL $script_url | bash -- $argv"
        end
    end

    getopts $argv | while read -l key value
        switch $key
            case h help
                ___usage
                return 0
            case g gimme
                __execute_gimme "$value"
            case V version
                set go_version "$value"
            case v verbose
                set -x DEBUG 'true'
        end
    end
    return 0

    function __go_change_version_set_env
        set -l new_version $argv[1]
        set -l go_path "$HOME/.gimme/versions/go$new_version"
        set -xU GOROOT $go_path
        utils.path.replace $go_path/bin '3'
    end

    if test -n "$go_version"
        contains -- $go_version $existing_versions
        and __go_change_version_set_env $go_version
        or __execute_gimme GIMME_SILENT_ENV=true GIMME_GO_VERSION=$go_version
    else
        set -l go_version (\
          string split ' ' $existing_versions |\
          fzf --select-1 --prompt 'Go version> ' --height 40%)
        log.info -m "Changing to go version $go_version"
        __go_change_version_set_env $go_version
    end
end
