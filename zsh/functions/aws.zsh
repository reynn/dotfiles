# -----------------------------------------------------------------------------
# AWS functions ---------------------------------------------------------------

function aws_get_instance_pricing() {
  local type=$1
  if [ "$type" = '-h' ]; then
    print_usage_json "$0"
    return 0
  fi

  print_debug "$@" "Input [$type]"

  local instance_types=()

  if test -n "$type"; then
    instance_types+=($type)
  else
    instance_types=($(aws \
                        --region us-east-1 \
                        pricing \
                        get-attribute-values \
                        --service-code AmazonEC2 \
                        --attribute-name instanceType | \
                        jq -r '.AttributeValues[].Value' | \
                        grep '\.' | \
                        sort | \
                        fzf --height=10 --ansi --reverse --select-1 --multi))
  fi

  local pricing_data=()

  for t in $instance_types; do
    print_info "$@" "Getting pricing for: $t"
    local instance_price="$(aws \
                              --region us-east-1 \
                              pricing \
                              get-products \
                              --filters "Type=TERM_MATCH,Field=instanceType,Value=$t" \
                                        "Type=TERM_MATCH,Field=operatingSystem,Value=Linux" \
                                        "Type=TERM_MATCH,Field=location,Value=US West (Oregon)" \
                                        "Type=TERM_MATCH,Field=preInstalledSw,Value=NA" \
                              --service-code AmazonEC2 | \
                              jq -r '.PriceList[0]' | \
                              jq -r '.terms.OnDemand[].priceDimensions[].pricePerUnit.USD')"
    pricing_data+=("{\"type\":\"$t\", \"hourly_price\": \"$instance_price\"}")
  done

  local table_data="Instance Type,Hourly,Monthly,Yearly,3 Year"

  for d in $pricing_data; do
    local type=$(echo $d | jq -r '.type')
    printf -v hourly "%.2f" "$(echo $d | jq -r '.hourly_price')"
    printf -v monthly "%.2f" "$(( $hourly*720 ))"
    printf -v yearly "%.2f" "$(( $monthly*12 ))"
    printf -v three_years "%.2f" "$(( $yearly*3 ))"
    table_data+="\n$type,\$$hourly,\$$monthly,\$$yearly,\$$three_years"
  done

  echo $table_data | tabulate -1 -f pipe -s ,
}

function aws_get_matching_stacks() {
  local matcher=$1
  if [ "$1" = '-h' ]; then
    print_usage_json "$0"
    return 0
  fi
  aws cloudformation list-stacks --query "StackSummaries[].StackName" | jq -r "map(match(\".*$matcher.*\"; \"ig\")) | .[].string"
}
