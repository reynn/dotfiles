function log.error -d "Log a error message"
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
        echo -e "\e[31m[ERROR]($label): $msg\e[0m" 1>&2
    else
        echo -e "\e[31m[ERROR]: $msg\e[0m" 1>&2
    end
end
