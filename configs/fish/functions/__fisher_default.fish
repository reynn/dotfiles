#!/usr/bin/env fish

function __fisher_default -d "Initialize a default Fisher config"
    functions -e fisher; or curl -sL https://git.io/fisher | source
    fisher install jorgebucaran/fisher 'jorgebucaran/getopts.fish' 'jorgebucaran/nvm.fish' 'PatrickF1/colored_man_pages.fish' sijad/gitignore IlanCosman/tide
end
