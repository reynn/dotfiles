#!/usr/bin/env fish

function aws.utils.json.run.instances -d "Create the necessary JSON data to send to AWS via the CLI" -a "AMIID"
    set -l ami_id ''
    set -l instance_type 't3.large'
    set -l launch_count '1'
    set -l role_type 'jkdkrs'
    set -l name "$USER-test-instance"
    set -l security_group ''
    set -l subnet_id ''

    getopts $argv | while read -l key value
        switch $key
            case a ami_id
                set ami_id $value
            case t instance_type
                set instance_type $value
            case c launch_count
                set launch_count $value
            case r role_type
                set role_type $value
            case n name
                set name $value
            case s security_group
                set security_group $value
            case subnet_id
                set subnet_id $value
        end
    end

    if test -z $ami_id
        echo "Must provide an AMI ID to generate JSON"
        return 1
    end
    if test -z $security_group
        set -l tmp_file (mktemp)
        aws ec2 describe-security-groups >$tmp_file
        set security_group (jq -r '.SecurityGroups[] | "\(.GroupId) \(.GroupName)"' $tmp_file |
                fzf --select-1 --prompt 'Security Group> ' --height 40% \
                  --preview 'aws ec2 describe-security-groups --group-ids {+1} --query "SecurityGroups[0]"')
        set security_group (string split ' ' $security_group)[1]
        log.debug -m "Selected security group $security_group"
        if test -z "$security_group"
            log.error -m "No security group selected"
            return 1
        end
    end
    if test -z $subnet_id
        set -l tmp_file (mktemp)

        set -l vpc_id (aws ec2 describe-security-groups --group-ids $security_group | jq -r '.SecurityGroups[0].VpcId')
        log.debug -m "SecurityGroup: $security_group is in VPC $vpc_id looking for matching subnets"
        aws ec2 describe-subnets --filters "Name=vpc-id,Values=$vpc_id" >$tmp_file
        set subnet_id (jq -r '.Subnets[] | "\(.SubnetId) \(if .Tags != null then .Tags[] | select(.Key == "Name").Value else "Not Tagged" end)"' $tmp_file |
                fzf --select-1 --prompt 'Subnets> ' --height 40% \
                --preview 'aws ec2 describe-subnets --subnet-ids {} | jq -r ".Subnets[0] | {AvailabilityZone,CidrBlock,State,VpcId,Tags}"'
        )
        set subnet_id (string split ' ' $subnet_id)[1]
        log.debug -m "Selected subnet $subnet_id"
    end

    log.debug -m "AMI_ID         $ami_id"
    log.debug -m "INSTANCE_TYPE  $instance_type"
    log.debug -m "COUNT          $launch_count"
    log.debug -m "ROLE_TYPE      $role_type"
    log.debug -m "SECURITY_GROUP $security_group"
    log.debug -m "SUBNET_ID      $subnet_id"

    if test -z $subnet_id || test -z $security_group
        return 1
    end

    jarg \
        "ImageId=$ami_id" \
        "InstanceType=$instance_type" \
        "SecurityGroupIds:=[\"$security_group\"]" \
        'MinCount:=1' \
        "MaxCount:=$launch_count" \
        'Monitoring[Enabled]:=false' \
        "SubnetId=$subnet_id" \
        'EbsOptimized:=true' \
        'KeyName=aws-ss-reTeam' \
        'IamInstanceProfile[Name]=delivery-pipeline-image-builder-imageBuilderProfile-CEW74VQKG6N3' \
        # 'CreditSpecification[CpuCredits]=Unlimited' \
        'InstanceInitiatedShutdownBehavior=terminate' \
        'BlockDeviceMappings[0][DeviceName]=/dev/sda1' \
        'BlockDeviceMappings[0][Ebs][VolumeSize]=256' \
        'BlockDeviceMappings[0][Ebs][VolumeType]=gp2' \
        'BlockDeviceMappings[0][Ebs][DeleteOnTermination]:=true' \
        'BlockDeviceMappings[0][Ebs][KmsKeyId]=arn:aws:kms:us-west-2:507365993774:key/46b618a2-ecc4-4581-9386-5bd219908fd7' \
        'BlockDeviceMappings[0][Ebs][Encrypted]:=true' \
        'TagSpecifications[0][ResourceType]=instance' \
        'TagSpecifications[0][Tags][0][Key]=Name' \
        "TagSpecifications[0][Tags][0][Value]=$name" \
        'TagSpecifications[0][Tags][1][Key]=Owner' \
        'TagSpecifications[0][Tags][1][Value]=nic.patterson@sap.com' \
        'TagSpecifications[0][Tags][2][Key]=RoleType' \
        "TagSpecifications[0][Tags][2][Value]=$role_type" \
        'TagSpecifications[1][ResourceType]=volume' \
        'TagSpecifications[1][Tags][0][Key]=Name' \
        "TagSpecifications[1][Tags][0][Value]=$name" \
        'TagSpecifications[1][Tags][1][Key]=Owner' \
        'TagSpecifications[1][Tags][1][Value]=nic.patterson@sap.com' \
        'TagSpecifications[1][Tags][2][Key]=RoleType' \
        "TagSpecifications[1][Tags][2][Value]=$role_type"
end
