function artifactory_get_my_uploads -d "Search for files that you have uploaded"
    set -l repo 'ext-yum-selfserve-local-v2'
    set -l time_frame '2d'
    set -l spec_file (mktemp -t my-uploads-spec.json)

    getopts $argv | while read -l key value
        switch $key
            case r repo
                set repo $value
            case t time_frame
                set time_frame $value
            case h
                echo "Usage: $0 [-h] -r [ARTIFACTORY_REPO] -t [TIME_FRAME]"
        end
    end

    jarg \
        "files[0][aql][items.find][repo]=$repo" \
        "files[0][aql][items.find][type]=file" \
        "files[0][aql][items.find][created_by]=$USER" \
        "files[0][aql][items.find][\$and][0][created][\$last]=$time_frame" | tee "$spec_file"

    jfrog rt search --spec $spec_file | jq -r '.[].path'
end
