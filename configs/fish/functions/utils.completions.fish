function utils.completions -d 'Show completions that have been added to our dotfiles repo'

    function ___usage
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case h help
                ___usage
                return 0
            case v verbose
                set -x DEBUG 'true'
        end
    end

    if test -x (command -s fd)
        fd -tf -e fish . $DFP/configs/fish/completions
    end
end
