#!/usr/bin/env fish

function artifactory.download -d "Download files from Artifactory based on a given pattern"
    set -l dry_run 'false'
    set -l flat 'false'
    set -l repo "ext-util-sandbox-local"
    set -l glob_match "*"
    set -l target "$PWD/"

    getopts $argv | while read -l key value
        switch $key
            case dry_run
                set dry_run $value
            case flat
                set flat = 'true'
            case repo
                set repo $value
            case target
                set target = "$value"
            case glob_match
                set glob_match "$value"
        end
    end

    set -l spec_file (mktemp -t download-spec.json)

    jarg \
        "files[0][target]=$target" \
        "files[0][repo]=$repo" \
        "files[0][flat]=$flat" \
        "files[0][pattern]=$repo/$glob_match" | tee $spec_file

    if test $dry_run = 'true'
        then
        jfrog rt download --dry-run --spec $spec_file
    else
        jfrog rt download --spec $spec_file
    end
end
