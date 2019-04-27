export SSH_KEY_PATH="~/.ssh/rsa_id"
export DEFAULT_NAMESPACE="development"
export PATH="$PATH:$HOME/go/bin:$HOME/git/bin"
# Git credentials
# Not in the repository, to prevent people from accidentally committing under my name
GIT_AUTHOR_NAME="Nic Patterson"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="arasureynn@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
