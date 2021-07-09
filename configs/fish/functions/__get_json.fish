#!/usr/bin/env fish

function __get_json --description ''
    set -lx local_cache_dir "$HOME/.cache/reynn"
    set -lx cache_timeout (math '(7*24)*(60*60)') # Timeout after 1 week
    set -lx urls

    getopts $argv | while read -l key value
        switch $key
            case t cache-timeout
                set cache_timeout "$value"
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
            case "*"
                set -a urls $value
        end
    end

    function __check_cache
        set -l url "$argv[1]"
        set -l cache_key (python3 -c "from urllib.parse import urlparse;u=urlparse('$url');print(f'{u.netloc}{u.path}')")
        set -l cache_path "$local_cache_dir/$cache_key"
        __log debug "Cache path       : $cache_path"
        test -d (dirname "$cache_path"); or mkdir -p (dirname "$cache_path")
        if test -f "$cache_path"
            set -l last_modified (math (date '+%s')"-"(stat -t %s -f %m -- "$cache_path"))
            __log debug "Last cached      : '$last_modified'"
            __log debug "Cache Timeout    : '$cache_timeout'"
            if test "$last_modified" -gt "$cache_timeout"
                __log debug "Deleteing cache file"
                /bin/rm -f $cache_path
            else
                __log debug "Cache still valid"
                echo $cache_path
                return
            end
        end
        command.is_available -c wget; and wget -q -O "$cache_path" "$url"; or curl -sSLs "$url" -o "$cache_path"
        echo $cache_path
    end

    __log debug "local_cache_dir  : $local_cache_dir"
    __log debug "cache_timeout    : $cache_timeout"
    __log debug "urls             : $urls"

    for url in $urls
        __check_cache "$url"
    end
end
