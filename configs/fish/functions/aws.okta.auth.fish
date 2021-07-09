function aws.okta.auth
    set -lx accounts_to_generate
    set -lx config_file_path "$HOME/.config/aws_okta_keyman.yaml"
    set -lx auth_file_path "$HOME/.config/aws_okta_keyman.auth.yaml"
    set -lx duration 3600
    set -lx password_reset false
    set -lx reup false
    set -lx fuzzy_filter
    set -lx aws_role_override

    function ___usage -d 'Show usage'
        set -l help_args -a "Use the AWS Okta Keyman tool to connect to get AWS credentials, FZF is used for user selection"

        # set -a help_args -a "# Example input yaml"
        # set -a help_args -a "```yaml"
        # set -a help_args -a "\---"
        # set -a help_args -a "okta:"
        # set -a help_args -a "  - name: AWS DA"
        # set -a help_args -a "    app_id: 0oa19f48n4x4jtFsZ1d8/272"
        # set -a help_args -a "    profile_name: aws-da"
        # set -a help_args -a "    okta_org: concur"
        # set -a help_args -a "    password_cache: true"
        # set -a help_args -a "    region: us-west-2"
        # set -a help_args -a "    role: aws-ss-reTeam"
        # set -a help_args -a "```"
        # set -a help_args -a "# Example auth yaml"
        # set -a help_args -a "\---"
        # set -a help_args -a "```yaml"
        # set -a help_args -a "cnqr:"
        # set -a help_args -a "  username: **@cnqr.tech"
        # set -a help_args -a "cnqr-cn:"
        # set -a help_args -a "  username: **"
        # set -a help_args -a "cnqr-nonprod:"
        # set -a help_args -a "  username: **"
        # set -a help_args -a "```"

        set -a help_args -f "a|account|The account to generate credentials for|"
        set -a help_args -f "c|config-file|The file containing account info|"(echo $config_file_path | string replace "$HOME" "~")
        set -a help_args -f "f|filter|Filter to start the fuzzy finder with|$fuzzy_filter"
        set -a help_args -f "d|duration|Set the duration the credential is valid for|$duration"
        set -a help_args -f "r|aws-role|Override the profiles role|`profile specific`"
        set -a help_args -f "R|reup|Run Keyman in a subshell with reup enabled|$reup"
        set -a help_args -f "|password-reset|Reset password cache|$password_reset"

        __dotfiles_help $help_args
    end

    function get_auth
        set -l auth_profile "$argv[1]"

    end

    getopts $argv | while read -l key value
        switch $key
            case _
                set -x -a accounts_to_generate "$value"
            case c config-file
                set config_file_path "$value"
            case f filter
                set fuzzy_filter "$value"
            case password-reset
                set password_reset true
            case r aws-role
                set aws_role_override "$value"
            case R reup
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
            __log debug "Using filter '$fuzzy_filter' on "(yq e -MN '.okta[].name' $config_file_path | count)" total accounts"
            set accounts_to_generate (yq e -MN '.okta[].name' $config_file_path | sk --height 30% --filter $fuzzy_filter --multi --select-1)
            __log debug "Filtered to "(count $accounts_to_generate)" accounts"
        else
            set accounts_to_generate (yq e -MN '.okta[].name' $config_file_path | sk --height 30% --multi --select-1)
        end
    end

    set account_count (count $accounts_to_generate)

    for account in $accounts_to_generate
        __log "Getting credentials for the [$account] account"
        set account_data (yq e ".okta[] | select(.name == \"$account\")" $config_file_path --tojson --indent 0)
        __log debug "Full account data: $account_data"

        set -lx username (echo $account_data | jq -r '.username' 2> /dev/null)
        set -lx appid (echo $account_data | jq -r '.app_id' 2> /dev/null)
        set -lx name (echo $account_data | jq -r '.name' 2> /dev/null)
        set -lx preview (echo $account_data | jq -r '.preview' 2> /dev/null)
        if test -n "$password_reset"
            set -lx password_reset (echo $account_data | jq -r '.password_reset' 2> /dev/null; or echo 'false')
        end
        set -lx region (echo $account_data | jq -r '.region' 2> /dev/null)
        set -lx account (echo $account_data | jq -r '.account' 2> /dev/null)
        set -lx org (echo $account_data | jq -r '."okta_org"' 2> /dev/null)
        set -lx profile_name (echo $account_data | jq -r '.profile_name' 2> /dev/null)
        set -lx bw_id (echo $account_data | jq -r '.bw_id | select (.!=null)' 2> /dev/null)
        set -lx role (echo $account_data | jq -r '.role' 2> /dev/null)

        __log debug "---> AWS Okta Keyman data"
        __log debug "username       : $username"
        __log debug "appid          : $appid"
        __log debug "name           : $name"
        __log debug "preview        : $preview"
        __log debug "passwordReset  : $password_reset"
        __log debug "region         : $region"
        __log debug "account        : $account"
        __log debug "role           : $role"
        __log debug "org            : $org"
        __log debug "profileName    : $profile_name"
        __log debug "bwId           : $bw_id"

        set -x keyman_args --region $region
        set -a keyman_args --org $org
        set -a keyman_args --username $username
        # Use keymans built in password cache by default, reset by providing '-R'
        set -a keyman_args --password_cache

        test -n $profile_name; and set -a keyman_args --name $profile_name
        test -n $appid; and set -a keyman_args --appid $appid
        test -n "$aws_role_override"; and set role "$aws_role_override"
        test -n "$role"; and set -a keyman_args --role $role
        test "$preview" = true; and set -a keyman_args --oktapreview
        test "$password_reset" = true; and set -a keyman_args -R
        test -n "$duration"; and set -a keyman_args -du $duration

        __log debug "calling [aws_okta_keyman $keyman_args]"

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
