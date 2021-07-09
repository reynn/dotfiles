#!/usr/bin/env fish

function docker.images.list -d "Show a list of images with minimal information"
    set -x columns Repository Tag Size

    function ___usage
        set -l help_args -a 'List all Docker images with only specific columns'
        set -a help_args -f '|clear-columns|Clear the current list of columns|false'
        set -a help_args -f "C|prepend-column|Prepend a column to the output|$columns"
        set -a help_args -f "c|add-column|Add a column to the output|$columns"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case clear-columns
                set -e columns
            case C prepend-column
                set -p columns "$value"
            case c add-column
                set -a columns "$value"
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

    if command.is_available -c docker
        __log error 'Docker is not installed'
        return 1
    end

    set -x output_format "table {{.$columns[1]}}\\t"
    for column in $columns[2..-1]
        set output_format "$output_format{{.$column}}\\t"
    end

    __log "Output format: $output_format"

    docker image list --all --format "$output_format" --filter "dangling=false"
end
