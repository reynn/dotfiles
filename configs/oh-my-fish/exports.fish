## Exports

# General ENV vars
set -xg GFP $HOME/git
set -xg DFP $GFP/github.com/reynn/dotfiles
set -xg REYNN $GFP/github.com/reynn
set -xg DFP $REYNN/dotfiles

# Language versions
set -xg LANGUAGES_PYTHON_VERSION '3.8'
set -xg LANGUAGES_GO_VERSION '1.14'
set -xg LANGUAGES_RUST_VERSION '1.43'

# Python exports
set -xg PYTHON_HOME (python3 -m site | grep USER_BASE | awk '{print $2}' | tr -d "\'")

# Go Exports
set -xg GOPATH $HOME/go
set -xg GO111MODULE on

# Path Exports
set -xg PATH $HOME/.bins $PATH
set -xg PATH $PYTHON_HOME/bin $PATH
set -xg PATH $HOME/go/bin $PATH
