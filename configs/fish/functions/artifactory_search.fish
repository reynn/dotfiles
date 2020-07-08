function artifactory_search -d "Search Artifactory for files"
    set -l glob_match "*"
    set -l repo "util-release"
    set -l pattern "$repo/*$glob_match*"

    getopts $argv | while read -l key value
        switch $key
            case glob_match
                set glob_match "$value"
            case repo
                set repo $value
            case pattern
                set pattern "$value"
        end
    end

    set -l spec_file (mktemp -t search-spec.json)

    jarg \
        "files[0][target]=$PWD" \
        "files[0][repo]=$repo" \
        "files[0][pattern]=$pattern" | tee $spec_file

    jfrog rt search --spec $spec_file
end
