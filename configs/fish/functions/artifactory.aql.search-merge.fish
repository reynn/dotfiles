#!/usr/bin/env fish
# TODO: Based on what this does it would be better as a flag to artifactory.aql.search
function artifactory.my.uploads -d "Search for files that you have uploaded"
    set -x creator "$USER"
    set -x repo ext-yum-selfserve-local-v2
    set -x time_frame 2d

    function ___usage
        set -l help_args -a 'Search for files that you have uploaded'
        set -a help_args -f "c|creator|The user that created the artifacts|$creator"
        set -a help_args -f "r|repo|The Artifactory repository to search for files|$repo"
        set -a help_args -f "t|time-frame|The upload time frame|$time_frame"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case c creator
                set creator "$value"
            case r repo
                set repo "$value"
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

    set -l spec_file (mktemp -t my-uploads-spec.json)

    jarg \
        "files[0][aql][items.find][repo]=$repo" \
        "files[0][aql][items.find][type]=file" \
        "files[0][aql][items.find][created_by]=$creator" \
        "files[0][aql][items.find][\$and][0][created][\$last]=$time_frame" | tee "$spec_file"

    jfrog rt search --spec $spec_file | jq -r '.[].path'
    rm -f $spec_file
end
