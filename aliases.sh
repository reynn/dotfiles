# Various aliases
alias ls="exa -lah --group-directories-first --time-style long-iso"
alias ll="ls --tree"
alias ansible-playbook="ansible-playbook --vault-password-file=$HOME/git/ansible/khalani/vaultpass.txt"
alias ansible="ansible --vault-password-file=$HOME/git/ansible/khalani/vaultpass.txt"
alias drun="docker run --rm -it -v "$(pwd):/tmp" -w /tmp --entrypoint=/bin/bash python"
alias gitclean='git reset --hard && git clean -fx'
