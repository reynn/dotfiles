set sourceables exports aliases ".host/"(hostname) ".secrets/"(hostname)

for sourceable in $sourceables
    set path "$OMF_CONFIG/$sourceable.fish"
    if test -e $path
        source $path
    end
end

## Source additional files
source "$GFP/github.com/junegunn/fzf/shell/key-bindings.fish"
if test -n (command -v starship)
    starship init fish | source
end
