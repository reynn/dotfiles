#!/usr/bin/env fish

function ip.get -d "Get the IP address either local or remote"
    set -l remote 'false'

    function ___usage
        set -l help_args -a '-f' "Get the IP address either local or remote"
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case r remote
                set remote 'true'
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

    if test "$remote" = 'true'
        log.info "Remote IP - "(dig +short myip.opendns.com @resolver1.opendns.com)
    else
        if test -x (command -s ipconfig)
            log.info "Local IP - "(ipconfig getifaddr en0)
        else
            log.info "Local IP - "(hostname -I)
        end
    end
end
