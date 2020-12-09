#!/usr/bin/env fish

function artifactory.search -d "Search Artifactory for files"
    set -lx glob_match "*"
    set -lx repo "util-release"
    set -lx pattern

    function ___usage
        set -l help_args '-a' 'Search Artifactory for files'
        set -a help_args '-f' "p|pattern|Overwrite the default pattern of (repo/*glob*)|$pattern"
        set -a help_args '-f' "r|repo|The Artifactory repository to search for files|$repo"
        set -a help_args '-f' "g|glob|An ant style pattern to match files|$glob_match"
        set -a help_args '-f' 'v|verbose|Additional verbose output|false'
        set -a help_args '-f' 'h|help|Print this help message'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case g glob
                set glob_match "$value"
            case r repo
                set repo "$value"
            case p pattern
                set pattern "$value"
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
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
