# dotfiles

## Prereqs

1. Fish
1. Git
1. Ansible

## Install

- Clone repo `git clone git@github.com:reynn/dotfiles $HOME/git/github.com/reynn/dotfiles`
- Run `ansible-playbook ansible/config.yaml` from the root of the project directory.

## Configuration Options

| Config          | Link                                         |
| --------------  | -------------------------------------------- |
| Terminal        | [Alacritty](configs/alacritty/readme.md)     |
| Shell           | [Fish Shell](configs/fish/readme.md)         |
| Prompt          | [Starship](configs/starship/readme.md)       |
| Multiplexer     | [TMUX](configs/tmux/readme.md)               |
| Neo(Vim) Config | [SpaceVim](configs/spacevim/readme.md)       |
