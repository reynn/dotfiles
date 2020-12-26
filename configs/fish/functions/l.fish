#!/usr/bin/env fish

function l --wraps 'exa' -d 'Preferred listing for directories'
    exa -lah --git-ignore --icons --git --group-directories-first --time-style long-iso --color-scale $argv
end
