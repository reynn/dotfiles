#!/usr/bin/env zsh

# -----------------------------------------------------------------------------
# Artifactory functions -------------------------------------------------------
# -----------------------------------------------------------------------------

function artifactory_upload() {
  local glob_match="*"
  local subfolder=""
  local repo="ext-util-sandbox-local"
  local flat='false'
  local dry_run='false'

  while getopts "dfhm:s:r:" opt; do
    case $opt in
    d) dry_run='true' ;;
    f) flat='true' ;;
    m) glob_match="$OPTARG" ;;
    s) subfolder="$OPTARG" ;;
    r) repo="$OPTARG" ;;
    h)
      echo "Usage: ${0:t} [-df] [-m glob_match] [-s SUBFOLDER] [-r REPO]"
      echo "-d: Dry Run"
      echo "-f: Flat upload"
      return 0
      ;;
    esac
  done

  if test -n "$subfolder"; then
    repo="$repo/$subfolder/"
  fi
  local pattern="$glob_match"
  local spec_file=$(mktemp -t upload-spec.json)

  jarg \
    "files[0][target]=$repo" \
    "files[0][recursive]=true" \
    "files[0][pattern]=$pattern" \
    "files[0][flat]=$flat" |
    tee $spec_file

  if test $dry_run = 'true'; then
    jfrog rt upload --dry-run --spec $spec_file
  else
    jfrog rt upload --spec $spec_file
  fi
}

function artifactory_download() {
  local glob_match="${1:-*}"
  local repo="${2:-util-release}"
  local pattern="$repo/*$glob_match*"
  local spec_file=$(mktemp -t download-spec.json)

  jarg \
    "files[0][target]=$PWD" \
    "files[0][repo]=$repo" \
    "files[0][pattern]=$pattern" |
    tee $spec_file

  jfrog rt download --spec $spec_file
}

function artifactory_search() {
  local glob_match="*"
  local repo="util-release"
  local pattern="$repo/*$glob_match*"
  local spec_file=$(mktemp -t search-spec.json)

  jarg \
    "files[0][target]=$PWD" \
    "files[0][repo]=$repo" \
    "files[0][pattern]=$pattern" |
    tee $spec_file

  jfrog rt search --spec $spec_file
}

function artifactory_get_my_uploads() {
  local repo='ext-yum-selfserve-local-v2'
  local time_frame='2d'
  local spec_file=$(mktemp -t my-uploads-spec.json)

  while getopts "hr:t:" opt; do
    case $opt in
    r) repo=$OPTARG ;;
    t) time_frame=$OPTARG ;;
    h)
      echo "Usage: ${0:t} [-h] -r [ARTIFACTORY_REPO] -t [TIME_FRAME]"
      exit 1
      ;;
    esac
  done

  jarg \
    "files[0][aql][items.find][repo]=$repo" \
    "files[0][aql][items.find][type]=file" \
    "files[0][aql][items.find][created_by]=$USER" \
    "files[0][aql][items.find][\$and][0][created][\$last]=$time_frame" |
    tee "$spec_file"

  jfrog rt search --spec $spec_file | jq -r '.[].path'
}
