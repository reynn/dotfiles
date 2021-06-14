#!/usr/bin/env fish

function dotfiles.fisher.update -d "Run updates for fisher"
    log "Updating fisher"
    test -f "$HOME/.config/fish/fish_plugins"; and fisher update; or __fisher_default
end
