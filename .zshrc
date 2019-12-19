# zmodload zsh/zprof # uncomment to debug performance issues with zsh startup
export GFP="$HOME/git"
export DFP="$GFP/github.com/reynn/dotfiles"
export HELP_JSON="$DFP/zsh/function_help.json"
export DIR_BINS="$HOME/.bins"
# export DEBUG='true'
FP="$DFP/zsh/.zshrc"

# -----------------------------------------------------------------------------
#### File Aliases -------------------------------------------------------------
alias ZE="vim $FP" # alias edit
alias ZR="source $FP" # alias reload

# -----------------------------------------------------------------------------
# Start -----------------------------------------------------------------------

source $DFP/zsh/2.functions/general.zsh
source $DFP/zsh/3.exports/general.zsh

# zstyle :omz:plugins:ssh-agent agent-forwarding on
case "$(hostname)" in
  C02VPB5XHTD6)
    zstyle :omz:plugins:ssh-agent identities aws-ss-reTeam.pem id_autocm id_ghe id_public_github id_rsa
    ;;
  *)
    zstyle :omz:plugins:ssh-agent identities id_rsa
    ;;
esac

# -----------------------------------------------------------------------------
# Antibody:Setup --------------------------------------------------------------
source <(antibody init)

# Setup required env var for oh-my-zsh plugins
export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"

antibody bundle robbyrussell/oh-my-zsh

local zsh_plugins=(
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
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir go_version vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv command_execution_time kubecontext aws status dir_writable)
HYPHEN_INSENSITIVE='true'
COMPLETION_WAITING_DOTS='true'

# -----------------------------------------------------------------------------
## ZSH:Functions --------------------------------------------------------------
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

local sourcePaths=(
  "$HOME/.gimme/envs/latest.env"
  "$HOME/.iterm2_shell_integration.zsh"
  "$GFP/github.com/thecasualcoder/kube-fzf/kube-fzf.sh"
)

print_debug 'sourcing additional files'
for sourceable in $sourcePaths; do
  import $sourceable
done

eval "$(pyenv init -)"

# zprof # uncomment to debug performance issues with zsh startup
