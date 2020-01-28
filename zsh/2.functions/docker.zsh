#!/usr/bin/env zsh

# -----------------------------------------------------------------------------
# Docker functions ------------------------------------------------------------
# -----------------------------------------------------------------------------

function docker_retag_and_push() {
  local image=$1
  if test -z $image; then
    print_usage_json "$0"
    return 0
  fi
  local tag="${2:-dev}"
  local registry="${3:-quay.io/reynn}"
  # split
  local splitImageName=("${(@f)$(helpers text split -d ':' "$image")}")
  # length
  if [ ${#splitImageName[@]} -eq 2 ]; then
    tag="${splitImageName[2]}"
  fi
  print_info "$0" "Retagging $image:$tag to $registry/$image:$tag"
  docker tag "$image" "$registry/$image:$tag"
}
