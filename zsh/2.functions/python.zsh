#!/bin/usr/env zsh

# -----------------------------------------------------------------------------
# Python functions ------------------------------------------------------------
# -----------------------------------------------------------------------------

function update_all_pip() {
  local packages=($(pip freeze | cut -d '=' -f 1))
  echo "Attempting to update ${#packages} packages using this pip install: $(command -v pip)..."
  pip install -U $packages
}

function get_files() {
  echo "$(run_commands get-files $@)"
}

function print_table_from_json() {
  echo "$(run_commands print-table-from-json $@)"
}

function run_commands() {
  echo "$(cd $DFP; pipenv run commands.py $@)"
}
