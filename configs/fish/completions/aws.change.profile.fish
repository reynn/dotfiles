#!/usr/bin/env fish

# --- aws.change.profile ---

complete -c 'aws.change.profile' -d 'Profile from cred-file to use' -l 'profile' -s 'p'
complete -c 'aws.change.profile' -d 'Delete the AWS_PROFILE variable so the CLI will use the default' -l 'erase' -s 'E'
