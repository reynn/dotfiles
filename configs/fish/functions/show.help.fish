#!/usr/bin/env fish

function show.help -d 'Specially formatted help messages'
    set -lx examples
    set -lx flags
    set -lx exit_codes '0|Successful'
    set -l system_platform (uname | string lower)
    set -l single_col_percent '0.1'
    set -l double_col_percent '0.2'

    test -f (command -v tput); and set -lx max_width (tput cols); or set -lx max_width 120
    if test $max_width -lt 80
      # Overall size should not be less than 80, though ideally it should be >100-120
      set max_width 80
    end
    set -lx last_trace (status stack-trace)[-1]

    set function_name (string replace --filter --regex 'in function \'(.+?)\'.+' '$1' $last_trace)

    set -lx single_col_width (math "round($max_width * $single_col_percent)")
    set -lx double_col_width (math "round($max_width * $double_col_percent)")

    getopts $argv | while read -l key value
        switch $key
            case a about
                set about "$value"
            case c exit-code
                set -a exit_codes "$value"
            case e example
                set -a examples "$value"
            case f flag
                set -a flags "$value"
            case v verbose
                set -x DEBUG 'true'
        end
    end

    log.debug -m "Function Name           : $function_name"
    log.debug -m "Last Trace              : $last_trace"
    log.debug -m "Terminal Width          : $max_width"
    log.debug -m "Single Column (w*$single_col_percent)   : $single_col_width"
    log.debug -m "Double Column (w*$double_col_percent)   : $double_col_width"
    log.debug -m "About                   : $about"
    log.debug -m "Flags                   : $flags"
    log.debug -m "#Flags                  : "(count $flags)
    log.debug -m "Examples                : $examples"
    log.debug -m "#Examples               : "(count $examples)
    log.debug -m "Name                    : $function_name"

    set -l table_row_format '| %s | %s | %s | %s |\n'

    set -lx desc_col_width (math "round($max_width - (4*$single_col_width))+10-"(string length $table_row_format))
    set -lx default_col_width (math "round($max_width-($desc_col_width+(2*$single_col_width))-13)")
    log.debug -m "Description Column (w-(4*col)) : $desc_col_width"
    log.debug -m "Default Column (w-(desc_w+2*s_col_w)) : $default_col_width"
    set -q HELP_COLOR; and set_color $HELP_COLOR; or set_color $fish_color_hg_added
    printf '# Usage: %s on %s\n\n' "$function_name" "$system_platform"

    if test -n "$about"
        printf '> %s\n\n' $about
    end

    if test (count $flags) -gt 0
        set -l header '## Flags '
        printf $header(string repeat -n (math $max_width-(string length $header)) '-')'\n\n'
        printf '| %-'$single_col_width's | %-'$single_col_width's | %-'$desc_col_width's | %-'$default_col_width's |\n' 'Short' 'Long' 'Description' 'Default'
        printf $table_row_format (string repeat -n $single_col_width '-') (string repeat -n $single_col_width '-') (string repeat -n $desc_col_width '-') (string repeat -n $default_col_width '-')
        for flag in $flags
            set -l short (string split '|' $flag)[1]
            set -l long (string split '|' $flag)[2]
            set -l description (string split '|' $flag)[3]
            set -l default (string split '|' $flag)[4]

            printf '| %-'$single_col_width's | %-'$single_col_width's | %-'$desc_col_width's | %-'$default_col_width's |\n' $short $long $description $default
        end
        echo ''
    end

    if test (count $examples) -gt 0
        set -l header '## Examples '
        printf $header(string repeat -n (math $max_width-(string length $header)) '-')'\n\n'
        for example in $examples
            echo -e "$function_name $example"
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
