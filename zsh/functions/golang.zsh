#!/usr/bin/env zsh

# -----------------------------------------------------------------------------
# Golang functions ------------------------------------------------------------
# -----------------------------------------------------------------------------

# Change go versions
function go_ch() {
  if test -n "$1"; then
    print_debug "Running Gimme with $1" 'version'
    eval "$(GIMME_SILENT_ENV=true gimme $1)"
  else
    print_debug "Sourcing latest Gimme env..." 'latest'
    test ! -L "$HOME/.gimme/envs/latest.env" || source "$HOME/.gimme/envs/latest.env"
  fi
}

# Get coverage report for testing go projects
function go_cover() {
  local t=$(mktemp -t cover)
  go test $COVERFLAGS -coverprofile=$t $@ &&
    go tool cover -func=$t &&
    unlink $t
}
