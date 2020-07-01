set sourceables exports aliases functions

for sourceable in $sourceables
    if test -e $OMF_CONFIG/$sourceable.fish
        source $OMF_CONFIG/$sourceable.fish
    end
end

## Source additional files
source "$GFP/github.com/junegunn/fzf/shell/key-bindings.fish"
