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
        command.is_available -c wget; and wget -q -O "$cache_path" "$url"; or curl -sSL "$url" -o "$cache_path"
        echo $cache_path
    end

    function ___get_cache_location
        set -l url "$argv"
        set -l cache_key (python3 -c "from urllib.parse import urlparse;u=urlparse('$url');print(f'{u.netloc}{u.path}')")
        set -l cache_file "$local_cache_dir/$cache_key"
        mkdir -p (dirname "$cache_file")
        echo $cache_file
    end

    function ___update_file_cache
        set -l local_cache_path "$argv[1]"
        set -l remote_url "$argv[2]"
        curl -SLs $remote_url -o "$local_cache_path"
    end

    function ___time_since_last_cache_update
        set -l cache_loc $argv
        set -l file_timestamp (stat --format '%W' -- "$cache_loc" 2>/dev/null)
        if test -z "$file_timestamp"
            echo (math "$cache_timeout * 2")
            return
        end
        set -l current_timestamp (date '+%s')
        math "$current_timestamp - $file_timestamp"
    end

    __log debug "local_cache_dir  : $local_cache_dir"
    __log debug "cache_timeout    : $cache_timeout"
    __log debug "urls             : $urls"

    for url in $urls
      set cache_loc (___get_cache_location $url)
      set last_updated_at (___time_since_last_cache_update "$cache_loc")
      if test "$last_updated_at" -gt "$cache_timeout"
          ___update_file_cache $cache_loc $url
      end
      dasel select -f $cache_loc -s '.'
    end
end
