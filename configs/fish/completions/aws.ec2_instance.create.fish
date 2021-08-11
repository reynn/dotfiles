#!/usr/bin/fish

# --- aws.ec2_instance.create ---

complete -c 'aws.ec2_instance.create' -d 'Stack name to use' -l 'stack-name' -s 's'
complete -c 'aws.ec2_instance.create' -d 'Bar separated list of tags' -l 'tag' -s 'T'
