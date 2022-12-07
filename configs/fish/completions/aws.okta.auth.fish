#!/usr/bin/env fish

# --- aws.okta.auth ---

complete -c 'aws.okta.auth' -d 'The account to generate credentials for' -l 'account-name' -s 'a'
complete -c 'aws.okta.auth' -d 'Filter to start the fuzzy finder with' -l 'filter' -s 'f'
complete -c 'aws.okta.auth' -d 'Set the duration the credential is valid for' -l 'duration' -s 'd'
complete -c 'aws.okta.auth' -d 'Override the profiles role' -l 'aws-role' -s 'r'
complete -c 'aws.okta.auth' -d 'Override the profiles name' -l 'aws-profile' -s 'p'
complete -c 'aws.okta.auth' -d 'The profile name that will be set in the credentials file' -l 'profile-name' -s 'n'
complete -c 'aws.okta.auth' -d 'Run Keyman in a subshell with reup enabled' -l 'reup'
complete -c 'aws.okta.auth' -d 'Reset password cache' -l 'password-reset'
