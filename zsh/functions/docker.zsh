# -----------------------------------------------------------------------------
# Docker functions ------------------------------------------------------------

function docker_retag_and_push() {
  local image=$1
  if test -z $image; then
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Description | Retag a Docker image with the provided tag and registry."
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Usage       | $0 <image> <tag> <registry>"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Parameters  |-----------------------------------------------------"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "image       | Name of an image to retag"
    print_usage "$0" "tag         | New tag name (Default: dev)"
    print_usage "$0" "registry    | The registry to push to (Default: quay.io/reynn)"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Example     | \`$0 test-image\`          (Retag test-image to quay.io/reynn/test-image:dev)"
    print_usage "$0" "Example     | \`$0 test-image:snapshot\` (Retag test-image:snapshot to quay.io/reynn/test-image:dev)"
    return 1
  fi
  local tag="${2:-dev}"
  local registry="${3:-quay.io/reynn}"
  # split
  local splitImageName=("${(@f)$(helpers text split -d ':' "$image")}")
  # length
  if [ ${#splitImageName[@]} -eq 2 ]; then
    tag="${splitImageName[2]}"
  fi
  print_info_label "$0" "Retagging $image:$tag to $registry/$image:$tag"
  docker tag "$image" "$registry/$image:$tag"
}
