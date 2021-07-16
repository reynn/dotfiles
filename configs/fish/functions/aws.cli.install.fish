function aws.cli.install --description 'Handle install and/or upgrade of AWS CLI package'
    set -lx base_directory "$HOME/.bins"
    set -lx latest_version (gh api /repos/aws/aws-cli/tags | jq -r '.[0].name')
    set -lx installed_version (cat $base_directory/aws-cli/installed_version 2>/dev/null; or echo '')

    if test -z "$installed_version"
        __log "AWS CLI is not installed"
    else
        __log "AWS CLI currently installed ($installed_version) latest ($latest_version)"
        if test "$installed_version" = "$latest_version"
            __log info "==> Up to date!"
            return
        else
            __log info "==> Installed but not on latest version"
            set -l choices_tmp_file (mktemp -t aws-cli-choices)
            set -l choices_tmp_file (mktemp -t aws-cli-choices)

            wget -q "https://awscli.amazonaws.com/AWSCLIV2-$latest_version.pkg"

            echo '<?xml version="1.0" encoding="UTF-8"?>' >$choices_tmp_file
            echo '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' >>$choices_tmp_file
            echo '<plist version="1.0">' >>$choices_tmp_file
            echo '<array>' >>$choices_tmp_file
            echo '<dict>' >>$choices_tmp_file
            echo '<key>choiceAttribute</key>' >>$choices_tmp_file
            echo '<string>customLocation</string>' >>$choices_tmp_file
            echo '<key>attributeSetting</key>' >>$choices_tmp_file
            echo "<string>$base_directory</string>" >>$choices_tmp_file
            echo '<key>choiceIdentifier</key>' >>$choices_tmp_file
            echo '<string>default</string>' >>$choices_tmp_file
            echo '</dict>' >>$choices_tmp_file
            echo '</array>' >>$choices_tmp_file
            echo '</plist>' >>$choices_tmp_file

            installer \
                -pkg "AWSCLIV2-$latest_version.pkg" \
                -target CurrentUserHomeDirectory \
                -applyChoiceChangesXML $choices_tmp_file

            if test $status -ne 0
                __log fail "Failed to install the AWS CLI"
                return 2
            end

            echo "$latest_version" >$base_directory/aws-cli/installed_version

            if not test -l "$base_directory/envs/aws"
                ln -s "$base_directory/aws-cli/aws" "$base_directory/envs/aws"
            end
            if not test -l "$base_directory/envs/aws_completer"
                ln -s "$base_directory/aws-cli/aws_completer" "$base_directory/envs/aws_completer"
            end
        end
    end
    __log info "==> completed"
end
