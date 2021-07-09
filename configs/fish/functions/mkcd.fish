#!/usr/bin/env fish

function mkcd -d 'Create a directory and cd into it in one shot'
    set -x dir $argv[1]

    __log debug "Creating directory $dir"
    mkdir -p "$dir"; and pushd "$dir"
end
