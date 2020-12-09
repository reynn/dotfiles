#!/usr/bin/env fish

function wget.download.remote.directory --wraps 'wget' -d ''
    set -lx download_urls

    function ___usage
        set -l help_args '-a' 'Downloads a directory tree from an http url using `wget`'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case u url
                set -a download_urls $value
            case h help
                ___usage
                return 0
            case v verbose
                set -x DEBUG 'true'
        end
    end

    for url in $download_urls
        wget -c -r -np -l1 -e robots=off -R "fileicon.png*" -R "index.html*" -nd $url
    end
end
