#!/usr/bin/env fish

function file.extract -d 'Extract a file [Port of OpenZSH extract plugin]'
    set -x archives_to_extract
    set -x extract_destination "."

    function ___usage -d 'Show usage'
        set -l help_args '-a' "Extract a file [Heavily inspired by OpenZSH extract plugin]"
        set -a help_args '-f' "d|destination|The target directory to extract files to|$extract_destination"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case _
                set -x -a archives_to_extract "$value"
            case d dest destination
                set destination "$value"
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET 'true'
            case v verbose
                set -x DEBUG 'true'
        end
    end

    for archive in $archives_to_extract
        log.info "Extracting archive $archive"
    end
end
