#!/usr/bin/env fish

function aws.utils.json.run.instances -d "Create the necessary JSON data to send to AWS via the CLI" -a "AMIID"
    set -l ami_id ""
    set -l instance_type 't3.large'
    set -l launch_count '1'
    set -l role_type 'jkdkrs'
    set -l name "$USER-test-instance"

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
        end
    end

    if test -z $ami_id
        echo "Must provide an AMI ID to generate JSON"
        return 1
    end

    log.debug -m "AMI_ID=$ami_id"
    log.debug -m "INSTANCE_TYPE=$instance_type"
    log.debug -m "COUNT=$launch_count"
    log.debug -m "ROLE_TYPE=$role_type"

    jarg \
        "ImageId=$ami_id" \
        "InstanceType=$instance_type" \
        'SecurityGroupIds:=["sg-0719467e"]' \
        "MaxCount:=$launch_count" \
        'MinCount:=1' \
        'Monitoring[Enabled]:=false' \
        'SubnetId=subnet-79ef0c1e' \
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
