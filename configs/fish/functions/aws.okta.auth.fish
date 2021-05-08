# Defined in /var/folders/g1/yb6lm8vn30l9n0fcjck955rr0000gn/T//fish.tnSdsJ/aws.okta.auth.fish @ line 2
function aws.okta.auth
    set -l accounts_to_generate
    set -lx config_file_path "$HOME/.config/reynn.aws_okta_keyman.yaml"
    function ___usage -d 'Show usage'
        set -l help_args -a "Use the AWS Okta Keyman tool to connect to get AWS credentials, FZF is used for user input"
        set -a help_args -a "Example input yaml"
        set -a help_args -a "---"
        set -a help_args -a "okta:"
        set -a help_args -a "  concur:"
        set -a help_args -a "   - name: AWS DA"
        set -a help_args -a "     app_id: 0oa19f48n4x4jtFsZ1d8/272"
        set -a help_args -a "     profile_name: aws-da"
        set -a help_args -a "     bw_id: 0f39edd0-e925-4f1b-bee0-acc40040c6d8"
        set -a help_args -a "     okta_org: concur"
        set -a help_args -a "     password_cache: true"
        set -a help_args -a "     region: us-west-2"
        set -a help_args -a "     role: aws-ss-reTeam"
        set -a help_args -a "     username: Nic.Patterson@concur.com"
        set -a help_args -f "a|account|The account to generate credentials for|"
        set -a help_args -f "c|config-file|The file containing account info|$config_file_path"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case a account
                set -x -a accounts_to_generate "$value"
            case a account
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
    set -l available_keyman_accounts (yq e '.okta.[].name' $HOME/.config/aws_okta_keyman.yaml --indent 0 --tojson)

    if test -z "$accounts_to_generate"
        log.debug "Available accounts: $available_keyman_accounts"
        set accounts_to_generate (echo $available_keyman_accounts | jq -r '.[].name' | fzf --multi --select-1)
    end
    return 3
    for account in $accounts_to_generate
        log info "Getting credentials for the [$account] account"
        set account_data (echo $available_keyman_accounts | jq ".[] | select(.name == \"$account\")")
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
        log.debug "calling aws_okta_keyman with $keyman_args"
        if test -z $bw_id
            echo $keyman_args | xargs aws_okta_keyman
        else
            bw get totp $bw_id | aws_okta_keyman $keyman_args
        end
    end
end
