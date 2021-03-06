#!/usr/bin/env fish

function path.replace

    set -x k $argv[1]
    set -x l $argv[2]
    if test -z $l
        set l 1
    end

    function __utils_path_replace_path
        __log debug "Removing base dirs for $k"
        set -l base_dir $k
        for iter in (seq $l)
            set base_dir (dirname $base_dir)
        end
        __log debug "Matching $base_dir in paths"
        set -l index 1
        for path in $PATH
            __log debug "path: $path"
            if string match -q "$base_dir*" "$path"
                __log debug "Removing [$index] $path from PATH"
                set -e PATH[$index]
                # break # break out of the loop looking for the right user path
            end
            set index (math $index + 1)
        end
    end

    function __utils_path_replace
        __log debug "Removing base dirs for $k"
        set -l base_dir $k
        for iter in (seq $l)
            set base_dir (dirname $base_dir)
        end
        __log debug "Matching $base_dir in fish_user_paths"
        set -l index 1
        # Look through fish_user_paths to see if the base_dir already exists
        for user_path in $fish_user_paths
            __log debug "fish_user_path: $user_path"
            if string match -q "$base_dir*" "$user_path"
                __log debug "Removing [$index] $user_path from fish_user_paths"
                # delete the path from fish_user_paths
                set -e fish_user_paths[$index]
            end
            set index (math $index + 1)
        end
        fish_add_path "$k"
    end

    function __utils_path_replace_usage
        set -l help_args -a 'Update a path for a versioned language, eg. Go 1.14 to Go 1.15'
        set -a help_args -e "\"$HOME/.gimme/versions/go1.15.4.darwin.amd64/bin\" '2'"
        set -a help_args -e "\"$HOME/.nvm/versions/node/v15.2.1/bin\" '2'"
        set -a help_args -e "\"$HOME/Library/Python/3.9/bin\" '2'"
        __dotfiles_help $help_args

    end

    if test "$argv[1]" = -h
        __utils_path_replace_usage
        return 0
    end

    contains -- $k $fish_user_paths; or __utils_path_replace $k $l
    contains -- $k $PATH; or __utils_path_replace_path $k $l
end
