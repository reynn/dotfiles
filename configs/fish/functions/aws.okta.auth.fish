# Defined in /var/folders/g1/yb6lm8vn30l9n0fcjck955rr0000gn/T//fish.tnSdsJ/aws.okta.auth.fish @ line 2
function aws.okta.auth
    set -lx accounts_to_generate
    set -lx config_file_path "$HOME/.config/aws_okta_keyman.yaml"
    set -lx duration 9001
    set -lx password_reset false

    function ___usage -d 'Show usage'
        set -l help_args -a "Use the AWS Okta Keyman tool to connect to get AWS credentials, FZF is used for user input\n\nExample input yaml\n---\nokta:\n  - name: AWS DA\n    app_id: 0oa19f48n4x4jtFsZ1d8/272\n    profile_name: aws-da\n    bw_id: 0f39edd0-e925-4f1b-bee0-acc40040c6d8\n    okta_org: concur\n    password_cache: true\n    region: us-west-2\n    role: aws-ss-reTeam\n    username: Nic.Patterson@concur.com"
        set -a help_args -f "a|account|The account to generate credentials for|"
        set -a help_args -f "c|config-file|The file containing account info|$config_file_path"
        set -a help_args -f "d|duration|Set the duration the credential is valid for|$duration"
        set -a help_args -f "R|password_reset|Reset password cache|$password_reset"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case a account
                set -x -a accounts_to_generate "$value"
            case c config-file
                set config_file_path "$value"
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

    log.debug "YQ Binary: "(which yq)" version "(yq --version | awk '{print $3}')
    log.debug "JQ Binary: "(which jq)" version "(jq --version | tr -d 'jq-')

    if test -z "$accounts_to_generate"
        log.debug "Available accounts: $available_keyman_accounts"
        set accounts_to_generate (yq e -MN '.okta[].name' $config_file_path | fzf --multi --select-1)
    end
    set -lx account_count (count $accounts_to_generate)
    for account in $accounts_to_generate
        log info "Getting credentials for the [$account] account"
        set account_data (yq e ".okta[] | select(.name == \"$account\")" $config_file_path --tojson --indent 0)
        log.debug "Full account data: $account_data"

        set -lx username (echo $account_data | jq -r '.username' 2> /dev/null)
        set -lx appid (echo $account_data | jq -r '.app_id' 2> /dev/null)
        set -lx name (echo $account_data | jq -r '.name' 2> /dev/null)
        set -lx preview (echo $account_data | jq -r '.preview' 2> /dev/null)
        set -lx password_reset (echo $account_data | jq -r '.password_reset' 2> /dev/null; or echo 'false')
        set -lx region (echo $account_data | jq -r '.region' 2> /dev/null)
        set -lx account (echo $account_data | jq -r '.account' 2> /dev/null)
        set -lx role (echo $account_data | jq -r '.role' 2> /dev/null)
        set -lx org (echo $account_data | jq -r '."okta_org"' 2> /dev/null)
        set -lx profile_name (echo $account_data | jq -r '.profile_name' 2> /dev/null)
        set -lx bw_id (echo $account_data | jq -r '.bw_id' 2> /dev/null)

        log.debug "---> AWS Okta Keyman data"
        log.debug "Username       : $username"
        log.debug "AppID          : $appid"
        log.debug "Name           : $name"
        log.debug "OktaPreview    : $preview"
        log.debug "PasswordReset  : $password_reset"
        log.debug "Region         : $region"
        log.debug "Account        : $account"
        log.debug "Role           : $role"
        log.debug "Org            : $org"
        log.debug "ProfileName    : $profile_name"

        set -x keyman_args --region $region --org $org --username $username --password_cache
        test -n $profile_name; and set -a keyman_args --name $profile_name
        test -n $appid; and set -a keyman_args --appid $appid
        test "$role" != null; and set -a keyman_args --role $role
        test "$preview" = true; and set -a keyman_args --oktapreview
        test "$password_reset" = true; and set -a keyman_args -R
        test -n "$duration"; and set -a keyman_args -du $duration
        log.debug "calling aws_okta_keyman with $keyman_args"
        if test -z $bw_id
            echo $keyman_args | xargs aws_okta_keyman
        else
            bw get totp $bw_id | aws_okta_keyman $keyman_args
        end
        set account_count (math "$account_count - 1")
        if test $account_count -gt 0
            log.info "Sleeping for 20 seconds"
            sleep 20
        end
    end
end
