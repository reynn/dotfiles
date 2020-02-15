#!/usr/bin/env zsh

_initializePreCommitHooks() {
  if test -d "$PWD/.git"; then
    local git_pre_commit_file="$PWD/.git/hooks/pre-commit"
    local pre_commit_config="$PWD/.pre-commit-config.yaml"
    # use test -x so we ensure it is executable
    if test ! -x $git_pre_commit_file && test -f $pre_commit_config; then
      echo "Installing pre-commit hooks..."
      pre-commit install -f
    fi
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _initializePreCommitHooks
