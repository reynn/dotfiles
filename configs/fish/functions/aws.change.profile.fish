function aws.change.profile
    set -lx credentials_file

    function ___usage -d 'Show usage'
        set -l help_args -a "Set AWS_PROFILE to a specific credential, with fuzzy finder support"

        set -a help_args -f "p|profile|Profile from cred-file to use|"
        set -a help_args -f "c|cred-file|The file containing AWS profiles|"(echo $credentials_file | string replace "$HOME" "~")
        set -a help_args -f "E|erase|Delete the AWS_PROFILE variable so the CLI will use the default|"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case c cred-file
                set credentials_file "$value"
            case p profile
                set selected_profile "$value"
            case E erase
                if set -q AWS_PROFILE
                    __log "Unsetting `$AWS_PROFILE` as the current profile"
                    set -e AWS_PROFILE
                end
                if set -q AWS_SHARED_CREDENTIALS_FILE
                    __log "Unsetting `$AWS_SHARED_CREDENTIALS_FILE` as the current credentials file"
                    set -e AWS_SHARED_CREDENTIALS_FILE
                end
                return 0
            case f filter
                set fuzzy_filter "$value"
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

    if test -n "$credentials_file"
        set -xg AWS_SHARED_CREDENTIALS_FILE "$credentials_file"
    else
        set credentials_file "$HOME/.aws/credentials"
    end

    if test -z "$selected_profile"
        set selected_profile (aws configure list-profiles | fzf --height 35% --prompt 'Profile> ' --preview='aws --profile {} sts get-caller-identity | dasel select -r json --plain -s "."')
    end

    set -xg AWS_PROFILE $selected_profile
end
