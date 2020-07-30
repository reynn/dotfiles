function go.change.version -d "Get a version of Go or source the latest environment from Gimme"
    set -l go_version "$argv[1]"
    set -l script_url 'https://raw.githubusercontent.com/travis-ci/gimme/master/gimme'

    if test -n "$go_version"
        log.debug -m "Running Gimme with version $go_version"
        curl -sL $script_url | env GIMME_SILENT_ENV=true GIMME_GO_VERSION=$go_version bash
    else
        set -l go_version (fd -td -d1 . ~/.gimme/versions/ -x echo '{/}' \; | sort -r -u | fzf --select-1 --prompt 'Go Version> ' --height 40%)
        set -l go_path "$HOME/.gimme/versions/$go_version"
        set -xU GOROOT $go_path
        # this will prevent it from readding the same version to the path
        contains $fish_user_paths $go_path/bin; or set -Up fish_user_paths $go_path/bin
    end
end
