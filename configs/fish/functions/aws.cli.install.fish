function aws.cli.install --description 'Handle install and/or upgrade of AWS CLI package'
    test ! -d $HOME/.bins; and mkdir -p $HOME/.bins
    set -lx latest_version (gh api /repos/aws/aws-cli/tags | jq -r '.[0].name')
    set -lx installed_version (cat $HOME/.bins/aws-cli/installed_version 2>/dev/null; or echo '')

    if test -z "$installed_version"
        log "AWS CLI is not installed"
    else
        log "AWS CLI currently installed ($installed_version) latest ($latest_version)"
        if test "$installed_version" = "$latest_version"
            echo "--> Up to date!"
            return
        else
            echo "--> Installed but not on latest version"
        end
    end
    log "--> completed <--"
end
