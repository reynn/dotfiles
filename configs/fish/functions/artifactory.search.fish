#!/usr/bin/env fish

function artifactory.search -d "Search Artifactory for files" -a glob_match repo pattern
    set -l glob_match "*"
    set -l repo "util-release"
    set -l pattern

    getopts $argv | while read -l key value
        switch $key
            case glob_match
                set glob_match "$value"
            case repo
                set repo "$value"
            case pattern
                set pattern "$value"
        end
    end

    if test -z $pattern
      set pattern "$repo/*$glob_match*"
    end

    set -l spec_file (mktemp -t search-spec.json)

    jarg \
        "files[0][target]=$PWD" \
        "files[0][repo]=$repo" \
        "files[0][pattern]=$pattern" | tee $spec_file

    jfrog rt search --spec $spec_file
end
