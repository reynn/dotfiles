#!/usr/bin/env fish

function wget.remote_directories.download --wraps wget -d ''
    set -x download_urls

    function ___usage
        set -l help_args -a 'Downloads a directory tree from an http url using `wget`'
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case _
                set -x -a download_urls "$value"
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

    for url in $download_urls
        wget -c -r -np -l1 -e robots=off -R "fileicon.png*" -R "index.html*" -nd $url
    end
end
