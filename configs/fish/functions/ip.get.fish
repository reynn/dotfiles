function ip.get -d "Get the IP address either local or remote"
    set -l remote 'false'

    function ___usage
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case h help
                ___usage
                return 0
            case v verbose
                set -x DEBUG 'true'
            case r remote
                set remote 'true'
        end
    end

    if test "$remote" = 'true'
        log.info -m "Remote IP - "(dig +short myip.opendns.com @resolver1.opendns.com)
    else
        if test -x (command -s ipconfig)
            log.info -m "Local IP - "(ipconfig getifaddr en0)
        else
            log.info -m "Local IP - "(hostname -I)
        end
    end
end
