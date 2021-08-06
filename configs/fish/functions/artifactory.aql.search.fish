#!/usr/bin/env fish

function artifactory.aql.search -d "Search Artifactory for files"
    set glob_match "*"
    set repo util-release
    set pattern
    set creator
    set time_frame

    function ___usage
        set -l help_args -a 'Search Artifactory for files'
        set -a help_args -f "p|pattern|Overwrite the default pattern of (repo/*glob*)|$pattern"
        set -a help_args -f "r|repo|The Artifactory repository to search for files|$repo"
        set -a help_args -f "g|glob|An ant style pattern to match files|$glob_match"
        set -a help_args -f "c|creator|The user that created the artifacts|$creator"
        set -a help_args -f "t|time-frame|The upload time frame|$time_frame"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case c creator
                set creator "$value"
            case g glob
                set glob_match "$value"
            case r repo
                set repo "$value"
            case p pattern
                set pattern "$value"
            case t time-frame
                set time_frame "$value"
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

    set spec_file (mktemp -t search-spec.json)

    if test -n "$creator"
        set spec_json (echo '{"files":[{"aql":{"items.find":{}}}]}' |\
          dasel put object -c -p json -s '.files.[0].aql.items\.find' \
          -t string -t string -t string \
          repo=test created_by=$USER type=file)
        set spec_json (echo $spec_json | dasel put object -p json \
          -s '.files.[0].aql.items\.find.\$and.[0].created' \
          -t string "\$last=2d")
        echo $spec_json | tee $spec_file
    else
        echo '{"files":[]}' | dasel put object -p json \
            -s '.files.[0]' \
            -t string -t string -t string \
            target=$target repo=$repo pattern="$repo/$glob_match" | tee $spec_file
    end
    jfrog rt search --spec $spec_file
end
