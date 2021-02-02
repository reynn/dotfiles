#!/usr/bin/env fish

function media.archive -d 'Move media files to a specified directory'
    set -lx icloud_directory "$HOME/Library/Mobile Documents/com~apple~CloudDocs"
    set -lx backup_directory "$icloud_directory"
    set -lx source_directory "$HOME/Downloads"
    set -lx extensions jpeg jpg png webp
    set -lx max_depth 1

    function ___usage
        set -l help_args -a "Move media files to a specified directory\n\n\tiCloud Directory: $icloud_directory"
        set -a help_args -f "b|backup-directory|Where media files will be moved to for archiving|[iCloud]"
        set -a help_args -f "s|source_directory|Where media files will be from during archiving|$source_directory"
        set -a help_args -f "e|extension|Include an additional extension to the list|$extensions"
        set -a help_args -f "E|clear-extensions|Clear the list of extensions to add a limitted set only|false"
        set -a help_args -f "d|depth|Maximum depth to iterate through|$max_depth"
        set -a help_args -e ' -E -e jpg # Include only jpg files'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case b backup-directory
                set backup_directory $value
            case s source-directory
                set source_directory $value
            case d depth
                if string match --quiet --regex '^\d+$' $value
                    set max_depth $value
                end
            case e ext
                set -a extensions $value
            case E clear-extensions
                set --erase extensions
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
        end
    end

    fd --type f \
        --max-depth=$max_depth \
        "--extension=$extensions" \
        . \
        --base-directory=$source_directory \
        --exec mv -nv "$source_directory/{/}" "$backup_directory/Pictures/{/}"
end
