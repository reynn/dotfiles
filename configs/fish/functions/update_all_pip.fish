function update_all_pip -d "Update all outdated Python packages using PIP"
    set -l packages (pip list --not-required --user --outdated --format json | jq -r '.[].name')
    echo "Attempting to update "(count packages)" packages using this pip install: "(command -v pip)"..."
    pip install -U $packages
end
