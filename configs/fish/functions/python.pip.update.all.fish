#!/usr/bin/env fish

function python.pip.update.all -d "Update all outdated Python packages using PIP"
    set -l pip_binary (command -v pip3)
    if test -z "$pip_binary"
      set pip_binary (command -v pip)
    end
    set -l packages ($pip_binary list --not-required --user --outdated --format json | jq -r '.[].name')
    if test (count $packages) -eq 0
        log.info -l 'pip.update' -m "Nothing to update"
        return 0
    end
    log.info -l 'pip.update' -m "Attempting to update "(count packages)" packages using this pip install: $pip_binary..."
    log.info -l 'pip.packages' -m "The following packages will attempt to update"
    for p in $package
      log.info -l 'package' -m "Package: $p"
    end
    log.info -l 'pip.packages' -m "---------------------------------------------"
    $pip_binary install --user -U $packages
end
