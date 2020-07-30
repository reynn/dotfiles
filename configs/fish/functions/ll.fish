#!/usr/bin/env fish

function ll --wraps='l --tree' --description 'alias ll "l --tree"'
    l --tree $argv
end
