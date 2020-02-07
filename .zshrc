# zmodload zsh/zprof # uncomment to debug performance issues with zsh startup

# -----------------------------------------------------------------------------
# Start -----------------------------------------------------------------------

export CURRENT_HOST="$(hostname)"
export TERM=xterm-256color

source $HOME/git/github.com/reynn/dotfiles/zsh/.vars/.reynn
source $DFP/zsh/.hosts/.$CURRENT_HOST
source $DFP/zsh/functions/.reynn
source $DFP/zsh/functions/text.zsh

# -----------------------------------------------------------------------------
# Antibody:Setup --------------------------------------------------------------
source <(antibody init)

# Setup required env var for oh-my-zsh plugins
export ZSH="$(antibody list | grep oh-my-zsh | awk '{print $2}')"

antibody bundle robbyrussell/oh-my-zsh

local zsh_plugins=(
  aws
  dircycle
  docker
  docker-compose
  encode64
  extract
  git
  git-hubflow
  httpie
  jsontools
  kubectl
  pip
  osx
  pipenv
  python
  rsync
  sudo
  tmux
)

antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle zsh-users/zsh-completions

for pl in $zsh_plugins; do
  antibody bundle robbyrussell/oh-my-zsh path:plugins/$pl
done

# Load the theme.
antibody bundle bhilburn/powerlevel9k path:powerlevel9k.zsh-theme

# -----------------------------------------------------------------------------
# ZSH -------------------------------------------------------------------------
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
## ZSH:Config -----------------------------------------------------------------
ZSH_THEME='powerlevel9k/powerlevel9k'
POWERLEVEL9K_PROMPT_ON_NEWLINE='true'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  context
  dir
  go_version
  vcs
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  virtualenv
  command_execution_time
  aws
  status
  dir_writable
)
HYPHEN_INSENSITIVE='true'
COMPLETION_WAITING_DOTS='true'

# -----------------------------------------------------------------------------
## ZSH:Functions --------------------------------------------------------------
# Overwrite the default which doesn't support GO projects using modules
prompt_go_version() {
  local go_version=$(go version 2>/dev/null | sed -E "s/.*(go[0-9.]*).*/\1/")
  local go_path=$(go env GOPATH 2>/dev/null)

  if [[ -n "$go_version" && ("${PWD##$go_path}" != "$PWD" || -f "$PWD/go.mod") ]]; then
    "$1_prompt_segment" "$0" "$2" "green" "grey93" "$go_version" "GO_ICON"
  fi
}

# -----------------------------------------------------------------------------
# Initialization --------------------------------------------------------------

for f in $IMPORT_DIRECTORIES; do
  import_zsh_files $f
done

source_paths=(
  "$HOME/.iterm2_shell_integration.zsh"
  "$GFP/github.com/thecasualcoder/kube-fzf/kube-fzf.sh"
)

print_debug 'sourcing additional files'
for sourceable in $source_paths; do
  test ! -r $sourceable || source $sourceable
done

go_ch

# If pyenv is installed on this machine initialize it
if test "$(command -v pyenv)"; then
  eval "$(pyenv init -)"
fi

# Initialize completions
autoload -U compinit && compinit

# zprof # uncomment to debug performance issues with zsh startup

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
