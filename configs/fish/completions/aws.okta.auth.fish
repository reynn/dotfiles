#!/usr/bin/env fish

complete -c aws.okta.auth -s a -l account-name -d 'The account to generate credentials for'
complete -c aws.okta.auth -s c -l config-file -d 'The file containing account info'
complete -c aws.okta.auth -s f -l filter -d 'Filter to start the fuzzy finder with'
complete -c aws.okta.auth -s d -l duration -d 'Set the duration the credential is valid for'
complete -c aws.okta.auth -s r -l aws-role -d 'Override the profiles role'
complete -c aws.okta.auth -s p -l aws-profile -d 'Override the profiles name'
complete -c aws.okta.auth -s n -l profile-name -d 'The profile name that will be set in the credentials file'
complete -c aws.okta.auth -l reup -d 'Run Keyman in a subshell with reup enabled'
complete -c aws.okta.auth -l password-reset -d 'Reset password cache'

complete -c aws.okta.auth -s v -l verbose -d "Enable debug logging"
complete -c aws.okta.auth -s h -l help -d "print usage help"
complete -c aws.okta.auth -s q -l quiet -d "quiet all logged output"
