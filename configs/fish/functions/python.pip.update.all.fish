#!/usr/bin/env fish

function python.pip.update.all -d "Update all outdated Python packages using PIP"
    set -l packages (python3 -m pip list --not-required --user --outdated --format json | jq -r '.[].name')
    if test (count $packages) -eq 0
        log.warning -m "Nothing to update"
        return 0
    end
    log.info -m "Attempting to update "(count packages)" packages using this pip install: python3 -m pip..."
    python3 -m pip install --user -U $packages
end
