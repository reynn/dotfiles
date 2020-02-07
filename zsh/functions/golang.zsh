#!/usr/bin/env zsh

# -----------------------------------------------------------------------------
# Golang functions ------------------------------------------------------------
# -----------------------------------------------------------------------------

# Change go versions
function go_ch() {
  if test -n "$1"; then
    print_info "Running Gimme with $1" 'version'
    eval "$(GIMME_SILENT_ENV=true gimme $1)"
  else
    print_info "Sourcing latest Gimme env..." 'latest'
    import "$HOME/.gimme/envs/latest.env"
  fi
}

# Get coverage report for testing go projects
function go_cover() {
  local t=$(mktemp -t cover)
  go test $COVERFLAGS -coverprofile=$t $@ &&
    go tool cover -func=$t &&
    unlink $t
}
