#!/usr/bin/env fish

function color.schemes.update -d "Read the latest from the colors.list file and update color scheme folders"
    set -l color_scheme_folder $GFP/github.com/mbadolato/iTerm2-Color-Schemes
    set -l colors (cat $DFP/color-schemes/colors.list)

    function ___usage
        set -l help_args '-a' 'Read the latest from the colors.list file and update color scheme folders'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
    end

    if not test -d $color_scheme_folder
        log.info -m "Cloning color scheme repo to $color_scheme_folder"
        git clone --depth 1 https://github.com/mbadolato/iTerm2-Color-Schemes $color_scheme_folder
    end

    pushd $color_scheme_folder
    git pull
    popd

    set command_cp (command -s cp)

    for color in $colors
        $command_cp -f "$color_scheme_folder/windowsterminal/$color.json" "$DFP/color-schemes/windows-terminal/$color.json" 2>/dev/null; or echo "Could not find color scheme [$color] for Windows Terminal"
        $command_cp -f "$color_scheme_folder/vscode/$color.json" "$DFP/color-schemes/vscode/$color.json" 2>/dev/null; or echo "Could not find color scheme [$color] for VS Code"
        $command_cp -f "$color_scheme_folder/schemes/$color.itermcolors" "$DFP/color-schemes/iterm/$color.itermcolors" 2>/dev/null; or echo "Could not find color scheme [$color] for iTerm2"
    end
end
