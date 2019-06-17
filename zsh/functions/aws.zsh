# -----------------------------------------------------------------------------
# Docker functions ------------------------------------------------------------

function aws_get_matching_stacks() {
  local matcher=$1
  if [ "$1" = '-h' ]; then
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Description | Get AWS CloudFormation stacks matching a certain criteria."
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Usage       | $0 <matcher>"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Parameters  |-----------------------------------------------------"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "image       | What to match when searching (Default *)"
    print_usage "$0" "------------------------------------------------------------------"
    print_usage "$0" "Example     | \`$0 *test*\` (Find stacks including the word test)"
    return 1
  fi
  aws cloudformation list-stacks --query "StackSummaries[].StackName" | jq -r "map(match(\".*$matcher.*\"; \"ig\")) | .[].string"
}
