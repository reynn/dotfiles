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
  local build_name=""
  local build_number=$(date '+%Y.%m.%d')

  while getopts "dfhm:N:n:s:r:" opt; do
    case $opt in
    d) dry_run='true' ;;
    f) flat='true' ;;
    m) glob_match="$OPTARG" ;;
    n) build_name="$OPTARG" ;;
    N) build_number="$OPTARG" ;;
    s) subfolder="$OPTARG" ;;
    r) repo="$OPTARG" ;;
    h)
      echo "Usage: ${0:t} [-df] [-n BUILD_NAME] [-N BUILD_NUMBER] [-m GLOB_MATCH] [-s SUBFOLDER] [-r REPO]"
      return 0
      ;;
    esac
  done

  if test -n "$subfolder"; then
    repo="$repo/$subfolder/"
  fi
  local pattern="$glob_match"
  local spec_file=$(mktemp -t upload-spec.json)
  local env_excludes='*ansible*;*artifactory*;*gfp*;*git*;*aws*;*jenkins*;*k8s*;*khalani*;*languages*;*fzf*;*go*;*helm*;*help*;*hist*;*home*;*iterm*;*creds*;*pager*;*debug*;*dfp*;*dir_bins*;*launchinstanceid*;*oldpwd*;*path*;*pipenv*;*pwd*;*pyenv*;*reynn*;*user*;*xdg*;*zsh*;'

  jarg \
    "files[0][target]=$repo" \
    "files[0][recursive]=true" \
    "files[0][pattern]=$pattern" \
    "files[0][flat]=$flat" |
    tee $spec_file

  if test $dry_run = 'true'; then
    jfrog rt upload --threads="$(sysctl -n hw.logicalcpu)" --dry-run --spec $spec_file --build-name="$build_name" --build-number="$build_number"
    jfrog rt build-collect-env "$build_name" "$build_number"
    jfrog rt build-add-git "$build_name" "$build_number"
    jfrog rt build-publish --dry-run --env-exclude $env_excludes "$build_name" "$build_number"
  else
    jfrog rt upload --threads="$(sysctl -n hw.logicalcpu)" --spec $spec_file --build-name="$build_name" --build-number="$build_number"
    jfrog rt build-collect-env "$build_name" "$build_number"
    jfrog rt build-add-git "$build_name" "$build_number"
    jfrog rt build-publish --env-exclude $env_excludes "$build_name" "$build_number"
  fi
}

function artifactory_download() {
  local glob_match="*"
  local repo="ext-util-sandbox-local"
  local flat='false'
  local dry_run='false'
  local target="$PWD/"

  while getopts "dfhm:s:r:t:" opt; do
    case $opt in
    d) dry_run='true' ;;
    f) flat='true' ;;
    m) glob_match="$OPTARG" ;;
    r) repo="$OPTARG" ;;
    t) target="$OPTARG" ;;
    h)
      echo "Usage: ${0:t} [-df] [-m GLOB_MATCH] [-r REPO] [-t TARGET]"
      return 0
      ;;
    esac
  done
  local spec_file=$(mktemp -t download-spec.json)

  jarg \
    "files[0][target]=$target" \
    "files[0][repo]=$repo" \
    "files[0][flat]=$flat" \
    "files[0][pattern]=$repo/$glob_match" |
    tee $spec_file

  if test $dry_run = 'true'; then
    jfrog rt download --dry-run --spec $spec_file
  else
    jfrog rt download --spec $spec_file
  fi
}

function artifactory_search() {
  local glob_match="*"
  local repo="util-release"
  local pattern="$repo/*$glob_match*"

  while getopts "hr:p:" opt; do
    case $opt in
    r) repo=$OPTARG ;;
    p) pattern=$OPTARG ;;
    h)
      echo "Usage: ${0:t} [-h] [-r REPO] [-p PATTERN]"
      return 0
      ;;
    esac
  done

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
      return 1
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
