#!/usr/bin/env fish

function artifactory.my.uploads -d "Search for files that you have uploaded"
    set -lx creator "$USER"
    set -lx repo 'ext-yum-selfserve-local-v2'
    set -lx time_frame '2d'

    function ___usage
        set -l help_args '-a' 'Search for files that you have uploaded'
        set -a help_args '-f' "c|creator|The user that created the artifacts|$creator"
        set -a help_args '-f' "r|repo|The Artifactory repository to search for files|$repo"
        set -a help_args '-f' "t|time-frame|The upload time frame|$time_frame"
        set -a help_args '-f' 'v|verbose|Additional verbose output|false'
        set -a help_args '-f' 'h|help|Print this help message'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case c creator
                set creator "$value"
            case r repo
                set repo "$value"
            case t 'time-frame'
                set time_frame "$value"
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
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
