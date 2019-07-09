#!/usr/bin/env zsh

function get_files() {
  echo "$(run_commands get-files $@)"
}

function run_commands() {
  echo "$(cd $DFP; pipenv run commands.py $@)"
}
