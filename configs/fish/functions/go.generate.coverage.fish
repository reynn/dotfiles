#!/usr/bin/env fish

function go.generate.coverage -d "Generate a coverage report for Golang"

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

    set -l t (mktemp -t cover)
    go test $COVERFLAGS -coverprofile=$t $argv
    go tool cover -func=$t
    unlink $t
end
