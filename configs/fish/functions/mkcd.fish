function mkcd -d 'Creates a directory then cd into automatically'
    function ___usage
      set -l help_args '-a' 'Creates a directory then cd into automatically'
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

    set -l function_args $argv
    set -l directory $function_args[1]
    set -l mkdir_args '-p'

    if test (count $function_args) -gt 1
        log.debug -m "Adding arguments to mkdirs list"
        for arg in $function_args[2..-1]
            log.debug -m "Adding [$arg] to args list"
            set -p mkdir_args "$arg"
        end
    end

    if test -z $directory
        log.error -m 'Please provide a directory name'
        return 2
    end

    log.debug -l 'directory' -m "$directory"
    log.debug -l 'mkdir.args' -m "[ $mkdir_args ]"
    mkdir $mkdir_args $directory; or return 2
    log.info -m "$directory created"
    cd $directory
end
