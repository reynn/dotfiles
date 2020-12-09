#!/usr/bin/env fish

function utils.path.add
    set -l k $argv[1]

    function __utils_path_add
        log.debug -m "Adding $argv to fish_user_paths"
        set -pU fish_user_paths $argv
    end

    contains -- $k $fish_user_paths; or __utils_path_add $k
end
