#!/usr/bin/env fish

function dotfiles.completions.generate -d 'Generate completions from the functions in this Dotfiles project'
    set -lx function_directory "$DFP/configs/fish/functions"
    set -lx completions_directory "$DFP/configs/fish/completions"
    set -lx line_filter '.+help_args -f (\'|")(.*?)(\'|")'

    function ___get_completion_file_lines
        __log debug " -------------- ___get_completion_file_lines"
        set -lx function_name
        set -lx short_flag
        set -lx long_flag
        set -lx description_text
        set -lx default_value

        getopts $argv | while read -l key value
            switch $key
                case n name
                    set function_name "$value"
                case s short
                    set short_flag "$value"
                case l long
                    set long_flag "$value"
                case d description
                    set description_text "$value"
                case D default
                    set default_value "$value"
            end
        end

        set -lx complete_args -c "'$function_name'" -d "'$description_text'" -l "'$long_flag'"

        if test -n "$short_flag"
            set -a complete_args -s "'$short_flag'"
        end
        __log debug "complete_cmd     : complete $complete_args"
        printf "complete %s" "$complete_args"
    end

    function ___usage
        set -l help_args -a 'Generate completions from the functions in this Dotfiles project'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
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

    set -lx function_files (fd --type file --extension fish . --base-directory "$function_directory")

    __log "Generating completions for "(count $function_files)" functions"

    for function_file in $function_files
        __log debug " -------------- function_files loop"
        set -l function_file "$function_directory/$function_file"
        set -l function_name (string split -m 1 -r '.' (basename $function_file))[1]
        set -l completion_file "$completions_directory/$function_name.fish"
        __log debug "function_file    : $function_file"
        __log debug "completion_file  : $completion_file"

        set -l filtered_lines (cat "$function_file" | string replace --filter --regex "^$line_filter\$" '$2')
        if test (count $filtered_lines) -eq 0
            __log debug "Unable to get lines from file"
            continue
        end
        set -lx complete_lines
        for line in $filtered_lines
            set -lx split_args (string split '|' "$line")
            set -lx split_count (count $split_args)
            __log debug "split_args       : $split_args"
            __log debug "len(split_args)  : $split_count"

            set -lx gen_args --name "$function_name"

            if test "$split_count" -eq 3
                if test (string length "$split_args[1]") -eq 1
                    set -a gen_args --short "$split_args[1]"
                    set -a gen_args --long "$split_args[1]"
                    set -a gen_args --description "$split_args[2]"
                else
                    set -a gen_args --long "$split_args[1]"
                    set -a gen_args --description "$split_args[2]"
                    set -a gen_args --default "$split_args[3]"
                end
            else if test "$split_count" -eq 4
                set -a gen_args --short "$split_args[1]"
                set -a gen_args --long "$split_args[2]"
                set -a gen_args --description "$split_args[3]"
                set -a gen_args --default "$split_args[4]"
            else
                __log error "Invalid arguments? [$line]"
                return 1
            end

            __log debug "___get_completion_file_lines $gen_args"
            set -a complete_lines (___get_completion_file_lines $gen_args)
        end
        __log debug " ------- "(count $complete_lines)" lines of completions"
        printf "#!/usr/bin/fish\n\n# --- $function_name ---\n\n"(string join '\n' $complete_lines)'\n' >$completion_file
    end
    __log "Completed generating completions"
end
