# -----------------------------------------------------------------------------
# GitHub functions ------------------------------------------------------------

function gh_get_assets() {
  local owner=$1
  local repo=$2
  local host=${3:-api.github.com}

  if test -z $1; then
    print_usage_json "$(get-help $0)"
    return 0
  fi
  helpers gh get --owner $owner --host $host --repo $repo asset --all
}
