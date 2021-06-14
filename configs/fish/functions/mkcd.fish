#!/usr/bin/env fish

function mkcd -d 'Create a directory and cd into it in one shot'
    set -x dir $argv[1]

    mkdir -p "$dir"; and pushd "$dir"
end
