function aws_ec2_create_run_instances_json -d "Create the necessary JSON data to send to AWS via the CLI" -a "AMIID"
    set -l ami_id ""
    getopts $argv | while read -l key value
        switch $key
            case a amiid
                set ami_id $value
        end
    end
    if test -z $ami_id
        echo "Must provide an AMI ID to generate JSON"
        return 1
    end
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
end
