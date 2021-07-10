#!/usr/bin/env fish

function __dotfiles_help -d 'Specially formatted help messages'
    set -x about_lines
    set -x examples
    set -x description_lines
    set flags 'v|verbose|Enable debug logging|false' 'h|help|Show this help message|false' 'q|quiet|quiet all logged output|false'
    set exit_codes '0|Successful' '1|Invalid arguments/Missing command'
    set system_platform (uname | string lower)

    set last_trace (status stack-trace)[-1]
    set function_name (string replace --filter --regex 'in function \'(.+?)\'.+' '$1' $last_trace)

    getopts $argv | while read -l key value
        switch $key
            case a about
                set -a about_lines "$value"
            case c exit-code
                set -a exit_codes "$value"
            case d description
                set -a description_lines "$value"
            case e example
                set -p examples "$value"
            case f flag
                set -p flags "$value"
                # Common args
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
        end
    end

    log debug "Function Name           : $function_name"
    log debug "Last Trace              : $last_trace"
    log debug "About                   : $about_lines"
    log debug "Flags                   : $flags"
    log debug "# Flags                 : "(count $flags)
    log debug "Examples                : $examples"
    log debug "# Examples              : "(count $examples)
    log debug "Name                    : $function_name"

    set -a complete_lines "# Usage: $function_name on $system_platform\n\n"

    if test -n "$about_lines"
        for about in $about_lines
            set -a complete_lines "> $about\n"
        end
        set -a complete_lines "\n"
    end

    if test -n "$description_line"
        for description in $description_line
            set -a complete_lines "$description\n"
        end
    end

    if test (count $flags) -gt 0
        set -a complete_lines '## Flags\n'
        set -a complete_lines '| Short | Long | Description | Default |\n'
        set -a complete_lines '| ----- | ---- | ----------- | ------- |\n'
        for flag in $flags
            set -l short (string split '|' $flag)[1]
            set -l long (string split '|' $flag)[2]
            set -l description (string split '|' $flag)[3]
            set -l default (string split '|' $flag)[4]

            set -a complete_lines "| $short | $long | $description | $default |\n"
        end
        set -a complete_lines "\n"
    end

    if test (count $examples) -gt 0
        set -a complete_lines "## Examples \n\n"
        # set -a complete_lines '```'
        for example in $examples
            set -a complete_lines "- `$function_name "(string trim -l $example)'`\n'
        end
        # set -a complete_lines '```'
        set -a complete_lines "\n"
    end

    if test (count $exit_codes) -gt 0
        set -a complete_lines "## Exit Codes \n"
        set -a complete_lines "| Code | Description |\n"
        set -a complete_lines "| ---- | ----------- |\n"
        for exit_code in $exit_codes
            set -l code (string split '|' $exit_code)[1]
            set -l result (string split '|' $exit_code)[2]

            set -a complete_lines "| $code | $result |\n"
        end
        set -a complete_lines "\n"
    end

    if test -x (command -v glow)
        printf "$complete_lines" | glow -
    else
        printf "$complete_lines"
    end
end
