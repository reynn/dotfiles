#!/usr/bin/env fish

function artifactory.aql.search -d "Search Artifactory for files"
    set -x glob_match "*"
    set -x repo util-release
    set -x pattern

    function ___usage
        set -l help_args -a 'Search Artifactory for files'
        set -a help_args -f "p|pattern|Overwrite the default pattern of (repo/*glob*)|$pattern"
        set -a help_args -f "r|repo|The Artifactory repository to search for files|$repo"
        set -a help_args -f "g|glob|An ant style pattern to match files|$glob_match"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case g glob
                set glob_match "$value"
            case r repo
                set repo "$value"
            case p pattern
                set pattern "$value"
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

    if not command.is_available -c jfrog
        __log error '`jfrog` is not installed'
        return 1
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
