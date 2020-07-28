function ip.get -d "Get the IP address either local or remote"
    set -l remote 'false'

    getopts $argv | while read -l key value
        switch $key
            case r remote
                set remote 'true'
        end
    end

    if test "$remote" = 'true'
        log.info -m "Remote IP - "(dig +short myip.opendns.com @resolver1.opendns.com)
    else
        log.info -m "Local IP - "(ipconfig getifaddr en0)
    end
end
