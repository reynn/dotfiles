function history -d 'Show the command history with included timestamp'

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
        end
    end

    builtin history --show-time="%m/%e %H:%M:%S | "
end
