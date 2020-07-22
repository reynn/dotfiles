function python.pip.update.all -d "Update all outdated Python packages using PIP"
    set -l packages (pip list --not-required --user --outdated --format json | jq -r '.[].name')
    if test (count $packages) -eq 0
        echo "Nothing to update"
        return 0
    end
    echo "Attempting to update "(count packages)" packages using this pip install: "(command -v pip)"..."
    pip install --user -U $packages
end
