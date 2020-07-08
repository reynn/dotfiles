function artifactory_upload -d "Upload files to Artifactory" -a glob_match subfolder repo flat dry_run build_name build_number
    set -l glob_match "*"
    set -l subfolder ""
    set -l repo "ext-util-sandbox-local"
    set -l flat 'false'
    set -l dry_run 'false'
    set -l build_name ""
    set -l build_number (date '+%Y.%m.%d')

    getopts $argv | while read -l key value
        switch $key
            case dry_run
                set dry_run $value
            case repo
                set repo $value
            case flat
                set flat = 'true'
            case build_name
                set build_name = "$value"
            case build_number
                set build_number "$value"
            case glob_match
                set glob_match "$value"
            case subfolder
                set subfolder "$value"
        end
    end

    if test -n "$subfolder"
        set repo "$repo/$subfolder/"
    end

    set -l pattern "$glob_match"
    set -l spec_file (mktemp -t upload-spec.json)
    set -l env_excludes '*ansible*;*artifactory*;*gfp*;*git*;*aws*;*jenkins*;*k8s*;*khalani*;*languages*;*fzf*;*go*;*helm*;*help*;*hist*;*home*;*iterm*;*creds*;*pager*;*debug*;*dfp*;*dir_bins*;*launchinstanceid*;*oldpwd*;*path*;*pipenv*;*pwd*;*pyenv*;*reynn*;*user*;*xdg*;*zsh*;'

    jarg \
        "files[0][target]=$repo" \
        "files[0][recursive]=true" \
        "files[0][pattern]=$pattern" \
        "files[0][flat]=$flat" | tee $spec_file

    if test $dry_run = 'true'
        jfrog rt upload --threads=(sysctl -n hw.logicalcpu) --dry-run --spec $spec_file --build-name="$build_name" --build-number="$build_number"
        jfrog rt build-collect-env "$build_name" "$build_number"
        jfrog rt build-add-git "$build_name" "$build_number"
        jfrog rt build-publish --dry-run --env-exclude $env_excludes "$build_name" "$build_number"
    else
        jfrog rt upload --threads=(sysctl -n hw.logicalcpu) --spec $spec_file --build-name="$build_name" --build-number="$build_number"
        jfrog rt build-collect-env "$build_name" "$build_number"
        jfrog rt build-add-git "$build_name" "$build_number"
        jfrog rt build-publish --env-exclude $env_excludes "$build_name" "$build_number"
    end
end
