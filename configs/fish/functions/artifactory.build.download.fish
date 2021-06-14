#!/usr/bin/env fish

## #######################################################################
## Examples
## #######################################################################
## `artifactory.download --dry_run --glob '*docker*'` -> Will dry run download files matching the docker patern
## `artifactory.download --glob '*docker*'` -> Will do the actual download of files found matching the docker pattern
## #######################################################################

function artifactory.build.download -d "Download files from Artifactory based on a given pattern"
    set -l dry_run false
    set -l flat false
    set -l repo ext-util-sandbox-local
    set -l glob_match "*"
    set -l target "$PWD/"

    function ___usage
        set -l help_args -a 'Download files from Artifactory based on a given pattern'
        set -a help_args -f "d|dry-run|Dont complete the download just test what would happen|$dry_run"
        set -a help_args -f "f|flat|Downloads subdirectories directly into the target directory|$flat"
        set -a help_args -f "r|repo|The Artifactory repository to search for files|$repo"
        set -a help_args -f "t|target|The target folder to download files to|$target"
        set -a help_args -f "g|glob|An ant style pattern to match files|$glob_match"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case d dry-run
                set dry_run true
            case f flat
                set flat true
            case r repo
                set -x repo "$value"
            case t target
                set target "$value"
            case g glob
                set glob_match "$value"
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

    if not command.is_available -c jfrog
        log error '`jfrog` is not installed'
        return 1
    end

    set -l spec_file (mktemp -t download-spec.json)

    jarg \
        "files[0][target]=$target" \
        "files[0][repo]=$repo" \
        "files[0][flat]=$flat" \
        "files[0][pattern]=$repo/$glob_match" | tee $spec_file

    if test $dry_run = true
        then
        jfrog rt download --dry-run --spec $spec_file
    else
        jfrog rt download --spec $spec_file
    end
end
