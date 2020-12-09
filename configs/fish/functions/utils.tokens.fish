function utils.tokens -d 'List all environment variables that have token in the name'
    function ___usage
        set -l help_args '-a' 'List all environment variables that have token in the name'
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case v verbose
                set -x DEBUG 'true'
            case h help
                ___usage
                return 0
        end
    end
    env | sort -u | grep -i token
end
