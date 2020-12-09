#!/usr/bin/env fish

function artifactory.upload -d "Upload files to Artifactory"
    set -lx glob_match '*'
    set -lx subfolder ''
    set -lx repo 'ext-util-sandbox-local'
    set -lx flat 'false'
    set -lx dry_run 'false'
    set -lx build_name ''
    set -lx build_number (date '+%Y.%m.%d(%H:%M:%S)')

    function ___usage
        set -l help_args '-a' 'Upload files to Artifactory'
        set -a help_args '-f' "d|dry-run|Run the command without uploading files|$dry_run"
        set -a help_args '-f' "f|flat|Files in subdirectories are uploaded to the base subfolder|$flat"
        set -a help_args '-f' "r|repo|The Artifactory repository to upload to|$repo"
        set -a help_args '-f' "n|build-name|Name of the Build that will be published|$build_name"
        set -a help_args '-f' "N|build-number|A unique number for the build|$build_number"
        set -a help_args '-f' "g|glob|An ant style pattern to match files|$glob_match"
        set -a help_args '-f' "s|subfolder|Create a subfolder in the target repo|$subfolder"
        set -a help_args '-f' 'v|verbose|Additional verbose output|false'
        set -a help_args '-f' 'h|help|Print this help message'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case d 'dry-run'
                set dry_run 'true'
            case f flat
                set flat 'true'
            case r repo
                set repo $value
            case n 'build-name'
                set build_name $value
            case N 'build-number'
                set build_number $value
            case g 'glob'
                set glob_match $value
            case s subfolder
                set subfolder $value
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
    end

    if test -n $subfolder
        set repo "$repo/$subfoldr/"
    end

    set -l pattern $glob_match
    set -l spec_file (mktemp -t upload-spec.json)
    set -l env_excludes '*ansible*;*artifactory*;*gfp*;*git*;*aws*;*jenkins*;*k8s*;*khalani*;*languages*;*fzf*;*go*;*helm*;*help*;*hist*;*home*;*iterm*;*creds*;*pager*;*debug*;*dfp*;*dir_bins*;*launchinstanceid*;*oldpwd*;*path*;*pipenv*;*pwd*;*pyenv*;*reynn*;*user*;*xdg*;*zsh*;*session*'

    jarg \
        "files[0][target]=$repo" \
        "files[0][recursive]=true" \
        "files[0][pattern]=$pattern" \
        "files[0][flat]=$flat" | tee $spec_file

    if test $dry_run = 'true'
        jfrog rt upload --threads=(sysctl -n hw.logicalcpu) --dry-run --spec $spec_file --build-name=$build_name --build-number=$build_number
        if test $status -eq 0
            jfrog rt build-collect-env $build_name $build_number
            jfrog rt build-add-git $build_name $build_number
            jfrog rt build-publish --dry-run --env-exclude $env_excludes $build_name $build_number
        else
            log.error -m 'Failed to upload files to artifactory' -l 'artifactory.upload(dry-run)'
        end
    else
        jfrog rt upload --threads=(sysctl -n hw.logicalcpu) --spec $spec_file --build-name=$build_name --build-number=$build_number
        if test $status -eq 0
            jfrog rt build-collect-env $build_name $build_number
            jfrog rt build-add-git $build_name $build_number
            jfrog rt build-publish --env-exclude $env_excludes $build_name $build_number
        else
            log.error -m 'Failed to upload files to artifactory' -l 'artifactory.upload'
        end
    end
end
