#!/usr/bin/env fish

function go.test_coverage.generate -d "Generate a coverage report for Golang tests"

    function ___usage
        set -l help_args '-a' 'Generate a coverage report for Golang tests'
        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET 'true'
            case v verbose
                set -x DEBUG 'true'
        end
    end

    set -l t (mktemp -t cover)
    go test $COVERFLAGS -coverprofile=$t $argv
    go tool cover -func=$t
    unlink $t
end
