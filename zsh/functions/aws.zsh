#!/usr/bin/env zsh

# -----------------------------------------------------------------------------
# AWS functions ---------------------------------------------------------------
# -----------------------------------------------------------------------------

function aws_ec2_ssh_to_instance_via_id {
  local instance_id=$1
  local instance_data=$(aws ec2 describe-instances --instance-ids "$instance_id" | jq -r '.Reservations[0].Instances[0]')
  local ip=$(echo "$instance_data" | jq -r '.PrivateIpAddress')
  local key_name=$(echo "$instance_data" | jq -r '.KeyName')
  local instance_name=$(echo "$instance_data" | jq -r '.Tags[] | select(.Key=="Name").Value')

  echo "Connecting to EC2 instance $instance_name [$ip] using $key_name"
  ssh -i ~/.ssh/${key_name}.pem ec2-user@$ip
}

function aws_ec2_connect_to_test_instance {
  local instance_id=$(aws \
    ec2 \
    describe-instances \
    --filters "Name=tag:Name,Values=$USER-test-instance" \
    "Name=instance-state-name,Values=running" |
    jq -r '.Reservations[].Instances[].InstanceId' |
    fzf --select-1)
  if ! test -z "$instance_id"; then
    aws_ec2_ssh_to_instance_via_id $instance_id
  fi
}

function aws_ec2_create_run_instances_json {
  local ami_id="$1"
  if test -z $ami_id; then
    echo "Must provide an AMI ID to generate JSON"
    return 1
  fi
  jarg \
    "ImageId=$ami_id" \
    'InstanceType=t3.large' \
    'SecurityGroupIds:=["sg-0719467e"]' \
    'MaxCount:=1' \
    'MinCount:=1' \
    'Monitoring[Enabled]:=true' \
    'SubnetId=subnet-79ef0c1e' \
    'EbsOptimized:=true' \
    'KeyName=aws-ss-reTeam' \
    'IamInstanceProfile[Name]=delivery-pipeline-image-builder-imageBuilderProfile-CEW74VQKG6N3' \
    'InstanceInitiatedShutdownBehavior=terminate' \
    'TagSpecifications[0][ResourceType]=instance' \
    'TagSpecifications[0][Tags][0][Key]=Name' \
    "TagSpecifications[0][Tags][0][Value]=$USER-test-instance" \
    'TagSpecifications[0][Tags][1][Key]=Owner' \
    'TagSpecifications[0][Tags][1][Value]=nic.patterson@sap.com' \
    'TagSpecifications[1][ResourceType]=volume' \
    'TagSpecifications[1][Tags][0][Key]=Name' \
    "TagSpecifications[1][Tags][0][Value]=$USER-test-instance" \
    'TagSpecifications[1][Tags][1][Key]=Owner' \
    'TagSpecifications[1][Tags][1][Value]=nic.patterson@sap.com' \
    'CreditSpecification[CpuCredits]=Unlimited'
}

function aws_ec2_create_test_instance {
  local force_search='false'
  local ami_id=''
  local ami_owner='966799970081'
  local ami_filter='golden-image-cis-centos-7.7'

  while getopts "a:f:ho:sv" opt; do
    case $opt in
    a) ami_id="$OPTARG" ;;
    f) ami_filter="$OPTARG" ;;
    o) ami_owner="$OPTARG" ;;
    s) force_search='true' ;;
    v) DEBUG='true' ;;
    h)
      echo "Usage: $0 -a [AMI_ID] -f [AMI_FILTER] -o [AMI_OWNER] -s -v"
      return 1
      ;;
    *)
      echo "Usage: $0 -a [AMI_ID] -f [AMI_FILTER] -o [AMI_OWNER] -s -v"
      return 1
      ;;
    esac
  done

  if test "$force_search" = 'true' || test -z $ami_id; then
    print_info "Finding latest image based on [filter: $ami_filter] and [owner: $ami_owner]"
    ami_id=$(
      aws \
        ec2 \
        describe-images \
        --filters "Name=name,Values=${ami_filter}*" \
        --owners "$ami_owner" \
        --query 'Images[-1].ImageId' \
        --output text
    )
    print_info "Latest AMI is $ami_id..."
  fi

  print_debug "force_search: $force_search"
  print_debug "ami_id: $ami_id"
  print_debug "ami_owner: $ami_owner"
  print_debug "ami_filter: $ami_filter"

  local instance=$(aws ec2 run-instances --output json --cli-input-json "$(aws_ec2_create_run_instances_json $ami_id)")

  print_info "Instance ID: $(echo $instance | jq -r '.Instances[0].InstanceId')"
  print_info "IP Address: $(echo $instance | jq -r '.Instances[0].PrivateIpAddress')"
}

function aws_ec2_cleanup_test_instances {
  local instance_ids=($(aws \
    ec2 \
    describe-instances \
    --filters "Name=tag:Name,Values=$USER-test-instance" \
    "Name=instance-state-name,Values=running,shut-down" |
    jq -r '.Reservations[].Instances[].InstanceId')
  )
  print_info "Found ${#instance_ids} instances to delete..."
  if test "${#instance_ids}" = '0'; then
    print_info 'No instances to cleanup...'
    return 1
  fi

  for instance_id in $instance_ids; do
    print_info "Deleting $instance_id"
    aws_ec2_tear_down_instance $instance_id
  done
}

function aws_ec2_tear_down_instance {
  local instance_id="$1"
  if test -z "$instance_id"; then
    echo "Please provide an AWS EC2 instance ID"
    return 1
  fi

  aws ec2 terminate-instances --instance-ids $instance_id |
    jq -r '.TerminatingInstances[] | "\(.InstanceId) is currently \(.CurrentState.Name)"'
}

function aws_ec2_get_instance_pricing {
  local type=$1
  if [ "$type" = '-h' ]; then
    print_usage_json "$0"
    return 0
  fi

  print_debug "Input [$type]"

  local instance_types=()

  if test -n "$type"; then
    instance_types+=($type)
  else
    instance_types=($(aws \
      --region us-east-1 \
      pricing \
      get-attribute-values \
      --service-code AmazonEC2 \
      --attribute-name instanceType |
      jq -r '.AttributeValues[].Value' | # Just get the instance type names
      grep '\.' |                        # Filter out the bases, c5, m3 etc
      sort -u |                          # Sort and get dedupe
      fzf --height=10 --ansi --reverse --select-1 --multi))
  fi

  local pricing_data=()

  for t in $instance_types; do
    print_debug "$@" "Getting pricing for: $t"
    local instance_price="$(aws \
      --region us-east-1 \
      pricing \
      get-products \
      --filters "Type=TERM_MATCH,Field=instanceType,Value=$t" \
      "Type=TERM_MATCH,Field=operatingSystem,Value=Linux" \
      "Type=TERM_MATCH,Field=location,Value=US West (Oregon)" \
      "Type=TERM_MATCH,Field=preInstalledSw,Value=NA" \
      --service-code AmazonEC2 |
      jq -r '.PriceList[0]' |
      jq -r '.terms.OnDemand[].priceDimensions[].pricePerUnit.USD')"
    pricing_data+=("{\"type\":\"$t\", \"hourly_price\": \"$instance_price\"}")
  done

  local table_data="Instance Type,Hourly,Monthly,Yearly,3 Year"

  for d in $pricing_data; do
    local type=$(echo $d | jq -r '.type')
    printf -v hourly "%.2f" "$(echo $d | jq -r '.hourly_price')"
    printf -v monthly "%.2f" "$(($hourly * 720))"
    printf -v yearly "%.2f" "$(($monthly * 12))"
    printf -v three_years "%.2f" "$(($yearly * 3))"
    table_data+="\n$type,\$$hourly,\$$monthly,\$$yearly,\$$three_years"
  done

  echo $table_data | tabulate -1 -f pipe -s ,
}

function aws_cfn_get_matching_stacks {
  local matcher=$1
  if [ "$1" = '-h' ]; then
    print_usage_json "$0"
    return 0
  fi
  aws cloudformation list-stacks --query "StackSummaries[].StackName" | jq -r "map(match(\".*$matcher.*\"; \"ig\")) | .[].string"
}
