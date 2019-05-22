# -----------------------------------------------------------------------------
# Golang functions ------------------------------------------------------------

# Change go versions
function go_ch() {
  if test -n "$1"; then
    print_info "Go $TXT_DIVIDER$FMT_INFO Running Gimme with $1"
    eval "$(gimme $1)"
  else
    print_info "Go $TXT_DIVIDER$FMT_INFO Sourcing latest Go env..."
    local env_file="$HOME/.gimme/envs/latest.env"
    if test -r $env_file; then
      source $env_file
    fi
  fi
}

# Get coverage report for testing go projects
function go_cover () {
  local t=$(mktemp -t cover)
  go test $COVERFLAGS -coverprofile=$t $@ \
    && go tool cover -func=$t \
    && unlink $t
}
