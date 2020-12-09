#!/usr/bin/env fish

function python.pip.update.all -d "Update all outdated Python packages using PIP"
    set -l packages (python3 -m pip list --disable-pip-version-check --not-required --user --outdated --format json | jq -r '.[].name')

    function ___usage
        show.help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case h help
                ___usage
                return 0
            case v verbose
                set -x DEBUG 'true'
        end
    end

    if test (count $packages) -eq 0
        log.warning -m "Nothing to update"
        return 0
    end
    log.info -m (count $packages)" packages need to be updated, including the following"
    for pkg in $packages
        log.info -l 'pkg' -m "--> $pkg"
    end
    python3 -m pip install --user -U $packages
end
