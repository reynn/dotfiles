function aws_ec2_ssh_to_instance_via_id -d "SSH to an AWS instance via it's ID instead of IP"
    set -l instance_id $argv[1]
    set -l instance_data (aws ec2 describe-instances --instance-ids "$instance_id" | jq -r '.Reservations[0].Instances[0]')
    set -l ip (echo "$instance_data" | jq -r '.PrivateIpAddress')
    set -l key_name (echo "$instance_data" | jq -r '.KeyName')
    set -l instance_name (echo "$instance_data" | jq -r '.Tags[] | select(.Key=="Name").Value')

    echo "instance_id [$instance_id]"
    echo "ip [$ip]"
    echo "key_name [$key_name]"
    echo "instance_name [$instance_name]"

    echo "Connecting to EC2 instance $instance_name [$ip] using $key_name"
    ssh -i ~/.ssh/$key_name.pem ec2-user@$ip
end
