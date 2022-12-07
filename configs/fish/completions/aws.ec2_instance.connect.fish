#!/usr/bin/env fish

# --- aws.ec2_instance.connect ---

complete -c 'aws.ec2_instance.connect' -d 'ID of the instance to connect to' -l 'instance-id' -s 'I'
complete -c 'aws.ec2_instance.connect' -d 'Set of filters to narrow down list of instances' -l 'filter' -s 'f'
complete -c 'aws.ec2_instance.connect' -d 'Removes all filters (Will grab all running instances)' -l 'no-filters' -s 'F'
complete -c 'aws.ec2_instance.connect' -d 'Method use to connect to the instance (ssh or ssm)' -l 'connect-method' -s 'c'
complete -c 'aws.ec2_instance.connect' -d 'The name of the SSH user to connect to' -l 'username' -s 'u'
complete -c 'aws.ec2_instance.connect' -d 'AWS Profile used for auth' -l 'profile' -s 'p'
