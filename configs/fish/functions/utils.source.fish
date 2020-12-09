#!/usr/bin/env fish

function utils.source -d "Source files if they exist"
    set -l sourceable_file $argv

    if test -e "$sourceable_file"
        log.debug -m "sourcing: $sourceable_file"
        source "$sourceable_file"
    end
end
