# -----------------------------------------------------------------------------
# GitHub functions ------------------------------------------------------------

function get_latest_gh_assets() {
  local owner=$1
  local repo=$2
  local host=${3:-api.github.com}

  if test -z $1; then
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Description | Create a new Minikube cluster with provided settings."
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Usage       | $0 <owner> <repo> <host>"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Parameters  |-----------------------------------------------------"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "owner       | The owner of the repository in GitHub"
    print_usage "$0" "repo        | The repository to get assets from"
    print_usage "$0" "host        | The API url to check. (Default: api.github.com)"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Example     | \`$0 stedolan jq\` (Get the assets for the most recent JQ release in GitHub)"
    print_usage "$0" "Example     | \`$0 stedolan jq api.github.enterprise.com\` (Get the latest assets from GCPD in Github Enterprise)"
    return 1
  fi
  helpers gh get --owner $owner --host $host --repo $repo asset --all
}
