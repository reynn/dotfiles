#!/usr/bin/env fish

function youtube.archive --wraps youtube-dl -d ''
    set -x download_urls

    function ___usage
        set -l help_args -a 'Run youtube-dl with pre-configured options'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
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

    set local_hostname (hostname -s | string lower)
    echo "local_hostname: $local_hostname"
    switch $local_hostname
        case mimikyu
            log "Running automation for $local_hostname"
        case '*'
            log error "There are no preconfigured archives for $local_hostname"
            return 2
    end
end
