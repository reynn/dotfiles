function aws.okta.auth
    set accounts_to_generate
    set config_file_path "$HOME/.config/aws_okta_keyman.yaml"
    set auth_file_path "$HOME/.config/aws_okta_keyman.auth.yaml"
    set aws_profile_name
    set duration 3600
    set password_reset false
    set aws_profile_override
    set reup false
    set fuzzy_filter
    set aws_role_override
    set cred_profile_name
    set accounts_to_generate

    function ___usage -d 'Show usage'
        set -l help_args -a "Use the AWS Okta Keyman tool to connect to get AWS credentials, FZF or Skim are used for user selection"

        set -a help_args -d "# Example input yaml\n---"
        set -a help_args -d "okta:"
        set -a help_args -d "  - name: AWS DA"
        set -a help_args -d "    app_id: 0oa19f48n4x4jtFsZ1d8/272"
        set -a help_args -d "    profile_name: aws-da"
        set -a help_args -d "    okta_org: concur"
        set -a help_args -d "    password_cache: true"
        set -a help_args -d "    region: us-west-2"
        set -a help_args -d "    role: aws-ss-reTeam"
        set -a help_args -d ""
        set -a help_args -d "# Example auth yaml\n---"
        set -a help_args -d "cnqr:"
        set -a help_args -d "  username: test-user@cnqr.tech"
        set -a help_args -d "cnqr-cn:"
        set -a help_args -d "  username: test-user"
        set -a help_args -d "cnqr-nonprod:"
        set -a help_args -d "  username: test-user"

        set -a help_args -f "a|account-name|The account to generate credentials for|"
        set -a help_args -f "c|config-file|The file containing account info|"(echo $config_file_path | string replace "$HOME" "~")
        set -a help_args -f "f|filter|Filter to start the fuzzy finder with|$fuzzy_filter"
        set -a help_args -f "d|duration|Set the duration the credential is valid for|$duration"
        set -a help_args -f "r|aws-role|Override the profiles role|`profile specific`"
        set -a help_args -f "p|aws-profile|Override the profiles name|`profile specific`"
        set -a help_args -f "n|profile-name|The profile name that will be set in the credentials file|`profile specific`"
        set -a help_args -f "|reup|Run Keyman in a subshell with reup enabled|$reup"
        set -a help_args -f "|password-reset|Reset password cache|$password_reset"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case a account-name
                set -a accounts_to_generate "$value"
            case c config-file
                set config_file_path "$value"
            case f filter
                set fuzzy_filter "$value"
            case n profile-name
                set cred_profile_name "$value"
            case p aws-profile
                set aws_profile_override "$value"
            case r aws-role
                set aws_role_override "$value"
            case reup
                set reup true
            case password-reset
                set password_reset true
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
        end
    end

    __log debug "Dasel Binary: $(which dasel) version $(dasel --version | awk '{print $3}')"

    if test -z "$accounts_to_generate"
        if test -n "$fuzzy_filter"
            __log debug "Using filter '$fuzzy_filter' on "(dasel select -f $config_file_path -m '.okta[#]')" total accounts"
            set accounts_to_generate (dasel select -f $config_file_path -m '.okta.[*].name' | fzf --height 40% --filter $fuzzy_filter --multi --select-1)
            __log debug "Filtered to "(count $accounts_to_generate)" accounts"
        else
            set accounts_to_generate (dasel select -f $config_file_path -m '.okta.[*].name' | fzf --height 40% --multi --select-1)
        end
    end

    set account_count (count $accounts_to_generate)

    if test "$reup" = true; and test $account_count -gt 1
        __log error "Cannot use reup with multiple accounts yet, selected ($account_count)"
        return 1
    end

    for account in $accounts_to_generate
        __log "Getting credentials for the [$account] account"
        set account_data (dasel select -f $config_file_path -s ".okta.(name=$account)" -w json -c)
        __log debug "Full account data: $account_data"

        set username (echo $account_data | dasel select -r json -n '.username' --plain 2>/dev/null)
        set appid (echo $account_data | dasel select -r json -n '.app_id' --plain 2>/dev/null)
        set preview (echo $account_data | dasel select -r json -n '.preview' --plain 2>/dev/null)
        set region (echo $account_data | dasel select -r json -n -s '.region' --plain 2>/dev/null)
        set org (echo $account_data | dasel select -r json -n -s '.okta_org' --plain 2>/dev/null)
        set bw_id (echo $account_data | dasel select -r json -n -s '.bw_id' --plain 2>/dev/null)
        set role (echo $account_data | dasel select -r json -n -s '.role' --plain 2>/dev/null)
        test -n "$aws_profile_name"; and set name $aws_profile_name; or set name (echo $account_data | dasel select -r json -n '.name' --plain 2>/dev/null)
        test -n "$aws_profile_override"; and set profile_name $aws_profile_override; or set profile_name (echo $account_data | dasel select -r json -n -s '.profile_name' --plain 2>/dev/null)

        __log debug "[---> AWS Okta Keyman data <---]"
        __log debug "username           : $username"
        __log debug "appid              : $appid"
        __log debug "name               : $name"
        __log debug "preview            : $preview"
        __log debug "passwordReset      : $password_reset"
        __log debug "region             : $region"
        __log debug "role               : $role"
        __log debug "org                : $org"
        __log debug "profileName        : $profile_name"
        __log debug "bwId               : $bw_id"
        __log debug "reup               : $reup"
        __log debug "cred_profile_name  : $cred_profile_name"
        __log debug "aws_role_override  : $aws_role_override"
        __log debug "duration           : $duration"

        set keyman_args --region "$region"
        set -a keyman_args --org "$org"
        set -a keyman_args --username "$username"
        # Use keymans built in password cache by default, reset by providing '--password-reset'
        set -a keyman_args --password_cache

        test -n "$cred_profile_name" && test "$cred_profile_name" != null; and set profile_name $cred_profile_name
        test -n "$profile_name" && test "$profile_name" != null; and set -a keyman_args --name "$profile_name"
        test -n "$appid" && test "$appid" != null; and set -a keyman_args --appid "$appid"
        test -n "$aws_role_override" && test "$aws_role_override" != null; and set role "$aws_role_override"
        test -n "$role" && test "$role" != null; and set -a keyman_args --role "$role"
        test -n "$duration" && test "$duration" != null; and set -a keyman_args -du $duration
        test "$preview" = true; and set -a keyman_args --oktapreview
        test "$password_reset" = true; and set -a keyman_args -R
        test "$reup" = true; and set -a keyman_args -r

        __log "aws_okta_keyman $keyman_args"
        # return 0
        if test -z "$bw_id"
            aws_okta_keyman $keyman_args
        else
            bw get totp $bw_id | aws_okta_keyman $keyman_args
        end

        set account_count (math "$account_count - 1")

        if test $account_count -gt 0
            __log "There are $account_count accounts left to process"
            __log "Sleeping for 20 seconds to ease Okta MFA limitting"
            sleep 20
        end
    end
end
