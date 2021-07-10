function aws.okta.auth
    set -lx accounts_to_generate
    set -lx config_file_path "$HOME/.config/aws_okta_keyman.yaml"
    set -lx auth_file_path "$HOME/.config/aws_okta_keyman.auth.yaml"
    set -lx aws_profile_name
    set -lx duration 3600
    set -lx password_reset false
    set -lx reup false
    set -lx fuzzy_filter
    set -lx aws_role_override

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

        set -p help_args -f "a|account|The account to generate credentials for|"
        set -p help_args -f "c|config-file|The file containing account info|"(echo $config_file_path | string replace "$HOME" "~")
        set -p help_args -f "f|filter|Filter to start the fuzzy finder with|$fuzzy_filter"
        set -p help_args -f "d|duration|Set the duration the credential is valid for|$duration"
        set -p help_args -f "p|aws-profile|Overwrite the profile name that will be written to credentials file|`profile specific`"
        set -p help_args -f "R|aws-role|Override the profiles role|`profile specific`"
        set -p help_args -f "r|reup|Run Keyman in a subshell with reup enabled|$reup"
        set -p help_args -f "|password-reset|Reset password cache|$password_reset"

        __dotfiles_help $help_args
    end

    function get_auth
        set -l auth_profile "$argv[1]"

    end

    getopts $argv | while read -l key value
        switch $key
            case a account
                set -a accounts_to_generate "$value"
            case c config-file
                set config_file_path "$value"
            case f filter
                set fuzzy_filter "$value"
            case password-reset
                set password_reset true
            case p aws-profile
                set aws_profile_name "$value"
            case R aws-role
                set aws_role_override "$value"
            case r reup
                set reup true
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

    __log debug "YQ Binary: "(which yq)" version "(yq --version | awk '{print $3}')
    __log debug "JQ Binary: "(which jq)" version "(jq --version | tr -d 'jq-')

    if test -z "$accounts_to_generate"
        if test -n "$fuzzy_filter"
            log debug "Using filter '$fuzzy_filter' on "(yq e -MN '.okta[].name' $config_file_path | count)" total accounts"
            set accounts_to_generate (yq e -MN '.okta[].name' $config_file_path | sk --height 40% --filter $fuzzy_filter --multi --select-1)
            log debug "Filtered to "(count $accounts_to_generate)" accounts"
        else
            set accounts_to_generate (yq e -MN '.okta[].name' $config_file_path | sk --height 40% --multi --select-1)
        end
    end

    set account_count (count $accounts_to_generate)

    if test "$reup" = true; and test $account_count -gt 1
        log error "Cannot use reup with multiple accounts yet, selected ($account_count)"
        return 1
    end

    for account in $accounts_to_generate
        __log "Getting credentials for the [$account] account"
        set account_data (yq e ".okta[] | select(.name == \"$account\")" $config_file_path --tojson --indent 0)
        __log debug "Full account data: $account_data"

        set -lx username (echo $account_data | jq -r '.username | select (.!=null)' 2> /dev/null)
        set -lx appid (echo $account_data | jq -r '.app_id | select (.!=null)' 2> /dev/null)
        set -lx name (echo $account_data | jq -r '.name | select (.!=null)' 2> /dev/null)
        if test -n "$aws_profile_name"
            set name "$aws_profile_name"
        end
        set -lx preview (echo $account_data | jq -r '.preview | select (.!=null)' 2> /dev/null)
        if test -n "$password_reset"
            set -lx password_reset (echo $account_data | jq -r '.password_reset | select (.!=null)' 2> /dev/null; or echo 'false')
        end
        set -lx region (echo $account_data | jq -r '.region | select (.!=null)' 2> /dev/null)
        set -lx account (echo $account_data | jq -r '.account | select (.!=null)' 2> /dev/null)
        set -lx org (echo $account_data | jq -r '.okta_org | select (.!=null)' 2> /dev/null)
        set -lx profile_name (echo $account_data | jq -r '.profile_name | select (.!=null)' 2> /dev/null)
        set -lx bw_id (echo $account_data | jq -r '.bw_id | select (.!=null)' 2> /dev/null)
        set -lx role (echo $account_data | jq -r '.role | select (.!=null)' 2> /dev/null)

        log debug "---> AWS Okta Keyman data"
        log debug "username       : $username"
        log debug "appid          : $appid"
        log debug "name           : $name"
        log debug "preview        : $preview"
        log debug "passwordReset  : $password_reset"
        log debug "region         : $region"
        log debug "account        : $account"
        log debug "role           : $role"
        log debug "org            : $org"
        log debug "profileName    : $profile_name"
        log debug "bwId           : $bw_id"
        log debug "reup           : $reup"

        set -x keyman_args --region "$region"
        set -a keyman_args --org "$org"
        set -a keyman_args --username "$username"
        # Use keymans built in password cache by default, reset by providing '--password-reset'
        set -a keyman_args --password_cache

        test -n "$profile_name"; and set -a keyman_args --name "$profile_name"
        test -n "$appid"; and set -a keyman_args --appid "$appid"
        test -n "$aws_role_override"; and set role "$aws_role_override"
        test -n "$role"; and set -a keyman_args --role "$role"
        test "$preview" = true; and set -a keyman_args --oktapreview
        test "$password_reset" = true; and set -a keyman_args -R
        test "$reup" = true; and set -a keyman_args -r
        test -n "$duration"; and set -a keyman_args -du "$duration"

        log debug "calling `aws_okta_keyman $keyman_args`"

        if test -z "$bw_id"
            aws_okta_keyman $keyman_args
        else
            bw get totp $bw_id | aws_okta_keyman $keyman_args
        end

        set account_count (math "$account_count - 1")

        if test $account_count -gt 0
            __log "There are $account_count accounts left to process"
            __log "Sleeping for 20 seconds"
            sleep 20
        end
    end
end
