function aws.cli.install --description 'Handle install and/or upgrade of AWS CLI package'
    set base_directory "$HOME/.local/bin"
    set latest_version (gh api /repos/aws/aws-cli/tags --jq '.[0].name')

    if test -e (which aws)
        set installed_version (aws --version | string split ' ' | head -1 | string split '/' | tail -1)
    end

    __log "AWS CLI currently installed ($installed_version) latest ($latest_version)"
    if test "$installed_version" = "$latest_version"
        __log info "==> Up to date!"
        return
    else
        set -l choices_tmp_file (mktemp -t aws-cli-choices)

        curl -s -o "/tmp/AWSCLIV2-$latest_version.pkg" "https://awscli.amazonaws.com/AWSCLIV2-$latest_version.pkg"

        echo '<?xml version="1.0" encoding="UTF-8"?>' >$choices_tmp_file
        echo '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' >>$choices_tmp_file
        echo '<plist version="1.0">' >>$choices_tmp_file
        echo '  <array>' >>$choices_tmp_file
        echo '    <dict>' >>$choices_tmp_file
        echo '      <key>choiceAttribute</key>' >>$choices_tmp_file
        echo '      <string>customLocation</string>' >>$choices_tmp_file
        echo '      <key>attributeSetting</key>' >>$choices_tmp_file
        echo "      <string>$base_directory</string>" >>$choices_tmp_file
        echo '      <key>choiceIdentifier</key>' >>$choices_tmp_file
        echo '      <string>default</string>' >>$choices_tmp_file
        echo '    </dict>' >>$choices_tmp_file
        echo '  </array>' >>$choices_tmp_file
        echo '</plist>' >>$choices_tmp_file

        installer \
            -pkg "/tmp/AWSCLIV2-$latest_version.pkg" \
            -target CurrentUserHomeDirectory \
            -applyChoiceChangesXML $choices_tmp_file

        if test $status -ne 0
            __log fail "Failed to install the AWS CLI"
            return 2
        end

        if not test -L "$base_directory/aws"
            ln -s "$base_directory/aws-cli/aws" "$base_directory/aws"
        end
        if not test -L "$base_directory/aws_completer"
            ln -s "$base_directory/aws-cli/aws_completer" "$base_directory/aws_completer"
        end
    end
    __log info "==> completed"
end
