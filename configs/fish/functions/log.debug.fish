function log.debug -d "Log a special information message"
    set -q DEBUG
    if test $status -gt 0
        return 0
    end
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
        echo -e "\e[32m[DEBUG]($label) $msg\e[0m" 1>&2
    else
        echo -e "\e[32m[DEBUG] $msg\e[0m" 1>&2
    end
end
