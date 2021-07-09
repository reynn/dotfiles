#!/usr/bin/env fish

function __dotfiles_help -d 'Specially formatted help messages'
    set examples
    set flags 'v|verbose|Enable debug logging|false' 'h|help|Show this help message|false' 'q|quiet|quiet all logged output|false'
    set exit_codes '0|Successful' '1|Invalid arguments/Missing command'
    set system_platform (uname | string lower)
    set single_col_percent '0.1'
    set double_col_percent '0.2'

    command.is_available -c tput; and set -x max_width (tput cols); or set -x max_width 120
    if test $max_width -lt 80
        # Overall size should not be less than 80, though ideally it should be >100-120
        set max_width 80
    end

    set last_trace (status stack-trace)[-1]
    set function_name (string replace --filter --regex 'in function \'(.+?)\'.+' '$1' $last_trace)
    set single_col_width (math "round($max_width * $single_col_percent)")
    set double_col_width (math "round($max_width * $double_col_percent)")
    set half_col_width (math "round($single_col_width/2)")
    set one_half_col_width (math "$half_col_width+$single_col_width")

    set -x about_lines

    getopts $argv | while read -l key value
        switch $key
            case a about
                set -a about_lines "$value"
            case c exit-code
                set -a exit_codes "$value"
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

    __log debug "Function Name           : $function_name"
    __log debug "Last Trace              : $last_trace"
    __log debug "Terminal Width          : $max_width"
    __log debug "Single Column (w*$single_col_percent)   : $single_col_width"
    __log debug "Double Column (w*$double_col_percent)   : $double_col_width"
    __log debug "About                   : $about_lines"
    __log debug "Flags                   : $flags"
    __log debug "# Flags                 : "(count $flags)
    __log debug "Examples                : $examples"
    __log debug "# Examples              : "(count $examples)
    __log debug "Name                    : $function_name"

    set -l table_row_format '| %s | %s | %s | %s |\n'

    set -x desc_col_width (math "round($max_width - (4*$single_col_width))+10-"(string length $table_row_format))
    set -x default_col_width (math "round($max_width-($desc_col_width+(2*$single_col_width))-14)")

    __log debug "Description Column (w-(4*col)) : $desc_col_width"
    __log debug "Default Column (w-(desc_w+2*s_col_w)) : $default_col_width"

    set -q HELP_COLOR; and set_color $HELP_COLOR; or set_color $fish_color_operator
    printf '# Usage: %s on %s\n\n' "$function_name" "$system_platform"

    if test -n "$about_lines"
        for about in $about_lines
            printf "\n> $about"
        end
        printf '\n\n'
    end

    if test (count $flags) -gt 0
        set -l header '## Flags '
        printf $header(string repeat -n (math $max_width-(string length $header)) '-')'\n\n'
        printf '| %-'$half_col_width's | %-'$one_half_col_width's | %-'$desc_col_width's | %-'$default_col_width's |\n' Short Long Description Default
        printf $table_row_format (string repeat -n $half_col_width '-') (string repeat -n $one_half_col_width '-') (string repeat -n $desc_col_width '-') (string repeat -n $default_col_width '-')
        for flag in $flags
            set -l short (string split '|' $flag)[1]
            set -l long (string split '|' $flag)[2]
            set -l description (string split '|' $flag)[3]
            set -l default (string split '|' $flag)[4]

            printf '| %-'$half_col_width's | %-'$one_half_col_width's | %-'$desc_col_width's | %-'$default_col_width's |\n' $short $long $description $default
        end
        echo ''
    end

    if test (count $examples) -gt 0
        set -l header '## Examples '
        printf $header(string repeat -n (math $max_width-(string length $header)) '-')'\n\n'
        for example in $examples
            echo -e "$function_name "(string trim -l $example)
        end
        echo ''
    end

    if test (count $exit_codes) -gt 0
        set -l header '## Exit Codes '
        printf $header(string repeat -n (math $max_width-(string length $header)) '-')'\n\n'
        for exit_code in $exit_codes
            set -l code (string split '|' $exit_code)[1]
            set -l result (string split '|' $exit_code)[2]

            printf '| %-'$single_col_width's | %-'(math "$max_width-($single_col_width+7)")'s |\n' $code $result
        end
        echo ''
    end

    set_color normal
end
