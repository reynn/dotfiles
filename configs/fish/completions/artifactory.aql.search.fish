#!/usr/bin/fish

# --- artifactory.aql.search ---

complete -c 'artifactory.aql.search' -d 'Overwrite the default pattern of (repo/*glob*)' -l 'pattern' -s 'p'
complete -c 'artifactory.aql.search' -d 'The Artifactory repository to search for files' -l 'repo' -s 'r'
complete -c 'artifactory.aql.search' -d 'An ant style pattern to match files' -l 'glob' -s 'g'
complete -c 'artifactory.aql.search' -d 'The user that created the artifacts' -l 'creator' -s 'c'
complete -c 'artifactory.aql.search' -d 'The upload time frame' -l 'time-frame' -s 't'
