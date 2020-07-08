function go_cover -d "Generate a coverage report for Golang"
    set -l t (mktemp -t cover)
    go test $COVERFLAGS -coverprofile=$t $argv
    go tool cover -func=$t
    unlink $t
end
