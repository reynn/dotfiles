function l --wraps='exa -lah --git-ignore --icons --group-directories-first --time-style long-iso --color-scale' --description 'Preferred output of EXA'
    exa -lah --git-ignore --icons --git --group-directories-first --time-style long-iso --color-scale $argv
end
