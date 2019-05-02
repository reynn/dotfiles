export SSH_KEY_PATH="~/.ssh/rsa_id"
export DEFAULT_NAMESPACE="development"
export PATH="$PATH:$HOME/go/bin:$HOME/git/bin"
export GO111MODULE="on"
# Git credentials
# Not in the repository, to prevent people from accidentally committing under my name
GIT_AUTHOR_NAME="Nic Patterson"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
