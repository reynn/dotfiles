#!/usr/bin/env fish

function utils.path.replace

    set -lx function_name (status current-function)
    set -lx k $argv[1]
    set -lx l $argv[2]
    if test -z $l
        set l '1'
    end

    function __utils_path_add
        log.debug -m "Adding $k to fish_user_paths"
        set -pU fish_user_paths $k
    end

    function __utils_path_replace_path
        log.debug -m "Removing base dirs for $k"
        set -l base_dir $k
        for iter in (seq $l)
            set base_dir (dirname $base_dir)
        end
        log.debug -m "Matching $base_dir in paths"
        set -l index 1
        for path in $PATH
            log.debug -m "path: $path"
            if string match -q "$base_dir*" "$path"
                log.debug -m "Removing [$index] $path from PATH"
                set -e PATH[$index]
                # break # break out of the loop looking for the right user path
            end
            set index (math $index + 1)
        end
    end

    function __utils_path_replace
        log.debug -m "Removing base dirs for $k"
        set -l base_dir $k
        for iter in (seq $l)
            set base_dir (dirname $base_dir)
        end
        log.debug -m "Matching $base_dir in fish_user_paths"
        set -l index 1
        # Look through fish_user_paths to see if the base_dir already exists
        for user_path in $fish_user_paths
            log.debug -m "fish_user_path: $user_path"
            if string match -q "$base_dir*" "$user_path"
                log.debug -m "Removing [$index] $user_path from fish_user_paths"
                # delete the path from fish_user_paths
                set -e fish_user_paths[$index]
            end
            set index (math $index + 1)
        end
        __utils_path_add $k
    end

    function __utils_path_replace_usage
        show.help -e "$function_name \"$HOME/.gimme/versions/go1.15.4.darwin.amd64/bin\" '2'" \
            -e "$function_name \"$HOME/.nvm/versions/node/v15.2.1/bin\" '2'" \
            -e "$function_name \"$HOME/Library/Python/3.9/bin\" '2'"
    end

    if test "$argv[1]" = "-h"
        __utils_path_replace_usage
        return 0
    end

    contains -- $k $fish_user_paths; or __utils_path_replace $k $l
    contains -- $k $PATH; or __utils_path_replace_path $k $l
end
