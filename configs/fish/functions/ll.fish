#!/usr/bin/env fish

function ll --wraps='l --tree --level 3' --wraps='exa' --description '[ALIAS] Recursive list of folder structure'
    l --tree --level 3 $argv
end
