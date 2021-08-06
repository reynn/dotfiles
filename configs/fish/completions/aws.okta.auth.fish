#!/usr/bin/env fish

set func_name "aws.okta.auth"

complete -c $func_name -s a -l account-name -d 'The account to generate credentials for'
complete -c $func_name -s c -l config-file -d 'The file containing account info'
complete -c $func_name -s f -l filter -d 'Filter to start the fuzzy finder with'
complete -c $func_name -s d -l duration -d 'Set the duration the credential is valid for'
complete -c $func_name -s r -l aws-role -d 'Override the profiles role'
complete -c $func_name -s p -l aws-profile -d 'Override the profiles name'
complete -c $func_name -s n -l profile-name -d 'The profile name that will be set in the credentials file'
complete -c $func_name -l reup -d 'Run Keyman in a subshell with reup enabled'
complete -c $func_name -l password-reset -d 'Reset password cache'

complete -c $func_name -s v -l verbose -d "Enable debug logging"
complete -c $func_name -s h -l help -d "print usage help"
complete -c $func_name -s q -l quiet -d "quiet all logged output"
