function aws_cfn_get_matching_stacks -d "Get a list of stacks that match the specified pattern"
    set -l matcher $argv[1]
    aws cloudformation list-stacks --query "StackSummaries[].StackName" | jq -r "map(match(\".*$matcher.*\"; \"ig\")) | .[].string"
end
