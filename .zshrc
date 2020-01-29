# zmodload zsh/zprof # uncomment to debug performance issues with zsh startup
autoload -U compinit

# -----------------------------------------------------------------------------
# Start -----------------------------------------------------------------------
export DEBUG=true
fpath=($fpath ~/.zsh/completion)
CURRENT_HOST="$(hostname)"

source $HOME/git/github.com/reynn/dotfiles/zsh/0.vars/general.zsh
source $DFP/zsh/2.functions/general.zsh
source $DFP/zsh/2.functions/text.zsh
source $DFP/zsh/3.exports/general.zsh

if test -d $DFP/zsh/5.hosts/$CURRENT_HOST; then
  print_info "Souring files for $CURRENT_HOST"
  files=($(fd -t f -p -e zsh . $DFP/zsh/5.hosts/$CURRENT_HOST))
  for f in $files; do
    source $f
  done
fi

# zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities $SSH_IDENTITIES

# -----------------------------------------------------------------------------
# Antibody:Setup --------------------------------------------------------------
source <(antibody init)

# Setup required env var for oh-my-zsh plugins
export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"

antibody bundle robbyrussell/oh-my-zsh

local zsh_plugins=(
  aws
  dircycle
  docker
  docker-compose
  encode64
  extract
  git
  git-flow
  git-hubflow
  gpg-agent
  httpie
  jsontools
  kubectl
  osx
  pip
  pipenv
  python
  rsync
  ssh-agent
  sudo
  tmux
  vscode
  web-search
)

for pl in $zsh_plugins; do
  antibody bundle robbyrussell/oh-my-zsh path:plugins/$pl
done

antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-syntax-highlighting
# Load the theme.
antibody bundle bhilburn/powerlevel9k path:powerlevel9k.zsh-theme

# -----------------------------------------------------------------------------
# ZSH -------------------------------------------------------------------------
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
## ZSH:Config -----------------------------------------------------------------
ZSH_THEME='powerlevel9k/powerlevel9k'
POWERLEVEL9K_PROMPT_ON_NEWLINE='true'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context
  dir
  go_version
  vcs
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv
  command_execution_time
  kubecontext
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
# Imports ---------------------------------------------------------------------

# -----------------------------------------------------------------------------
## Imports:Function -----------------------------------------------------------

export IMPORT_DIRECTORIES=($DFP/zsh)

alias izf="import_zsh_files $IMPORT_DIRECTORIES"
izf

local source_paths=(
  "$HOME/.gimme/envs/latest.env"
  "$HOME/.iterm2_shell_integration.zsh"
  "$GFP/github.com/thecasualcoder/kube-fzf/kube-fzf.sh"
)

print_debug 'sourcing additional files'
for sourceable in $source_paths; do
  import $sourceable
done

# -----------------------------------------------------------------------------
# Initialization --------------------------------------------------------------

# If pyenv is installed on this machine initialize it
if [[ -n "$(command -v pyenv)" ]]; then
  eval "$(pyenv init -)"
fi

# Initialize completions
compinit

# zprof # uncomment to debug performance issues with zsh startup

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
