#!/usr/bin/env fish

function processes.kill -d 'Kill all processes that match the provided name'
    set -x process_name

    function ___usage
        set -l help_args -a 'Kill all processes that match the provided name'
        set -a help_args -f "n|name|Name of process to kill|$process_name"
        set -a help_args -e ' -n ssh-agent'
        set -a help_args -e ' -n tabnine'
        set -a help_args -e ' -n rust-analyzer'
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case n name
                set -x process_name "$value"
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
        end
    end

    set -l process_ids (ps aux | rg "$process_name" | rg -v "rg" | awk '{print $2}')
    set -l process_count (count $process_ids)

    if test $process_count -eq 0
        __log debug "No processes matched [$process_name] using `rg`"
        return 0
    end

    __log debug "Found $process_count processes named [$process_name]"
    __log debug "Process_ids: [$process_ids]"
    for process in $process_ids
        set -l cmd (ps -eo command $process | tail -n1)
        __log debug "Process [id: $process, cmd: $cmd]"
    end

    kill -9 $process_ids
end
