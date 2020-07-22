function log.info -d "Log a special information message"
    set -l label ''
    set -l msg ''

    getopts $argv | while read -l key value
        switch $key
            case l label
                set label $value
            case m message
                set msg $value
        end
    end

    if test -z $msg
        return 0
    end

    if test -n $label
        echo -e "\e[36m[INFO]($label) $msg\e[0m" 1>&2
    else
        echo -e "\e[36m[INFO] $msg\e[0m" 1>&2
    end
end
