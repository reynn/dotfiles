#!/usr/bin/env zsh

function get_files() {
  echo "$(run_commands get-files $@)"
}

function print_table_from_json() {
  echo "$(run_commands print-table-from-json $@)"
}

function run_commands() {
  echo "$(cd $DFP; pipenv run commands.py $@)"
}
