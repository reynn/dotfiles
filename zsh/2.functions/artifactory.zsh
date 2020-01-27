#!/bin/usr/env zsh

# -----------------------------------------------------------------------------
# Artifactory functions -------------------------------------------------------
# -----------------------------------------------------------------------------

function artifactory_upload() {
  local matcher="${1:-*}"
  local subfolder="${2:-}"
  local repo="${3:-ext-util-sandbox-local}"
  if test -n "$subfolder"; then
    repo="$repo/$subfolder/"
  fi
  local pattern="$PWD/$matcher"
  local spec_file="/tmp/$(date '+%Y%m%d-%H%M%S')-upload-spec.json"

  jarg \
    "files[0][target]=$repo" \
    "files[0][pattern]=$pattern" |
    tee $spec_file

  jfrog rt upload --spec $spec_file
}

function artifactory_download() {
  local matcher="${1:-*}"
  local repo="${2:-util-release}"
  local pattern="$repo/*$matcher*"
  local spec_file="/tmp/$(date '+%Y%m%d-%H%M%S')-download-spec.json"

  jarg \
    "files[0][target]=$PWD" \
    "files[0][repo]=$repo" \
    "files[0][pattern]=$pattern" |
    tee $spec_file

  jfrog rt download --spec $spec_file
}

function artifactory_search() {
  local matcher="${1:-*}"
  local repo="${2:-util-release}"
  local pattern="$repo/*$matcher*"
  local spec_file="/tmp/$(date '+%Y%m%d-%H%M%S')-search-spec.json"

  jarg \
    "files[0][target]=$PWD" \
    "files[0][repo]=$repo" \
    "files[0][pattern]=$pattern" |
    tee $spec_file

  jfrog rt search --spec $spec_file
}
