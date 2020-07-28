## Exports

# General ENV vars
set -xg GFP $HOME/git
set -xg DFP $GFP/github.com/reynn/dotfiles
set -xg REYNN $GFP/github.com/reynn
set -xg DFP $REYNN/dotfiles

# Language versions
set -xg LANGUAGES_PYTHON_VERSION '3.8'
set -xg LANGUAGES_GO_VERSION '1.14'
set -xg LANGUAGES_RUST_VERSION '1.45'

# Python exports
set -xg PYTHON_HOME (python3 -m site | string replace --filter -r 'USER_BASE\: \'(.+?)\'( \(exists\))?' \$1)

# Go Exports
set -xg GOPATH $HOME/go
set -xg GO111MODULE on

# Path Exports
set -p PATH $HOME/.bins
set -p PATH $PYTHON_HOME/bin
set -p PATH $HOME/go/bin
set -p PATH $GFP/github.com/junegunn/fzf/bin
set -p PATH $DFP/scripts

# FZF
set -xg FZF_DEFAULT_OPTS "--height 50% --layout=reverse --border"
set -xg FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'
