# zmodload zsh/zprof # uncomment to debug performance issues with zsh startup

# -----------------------------------------------------------------------------
# Start -----------------------------------------------------------------------

CURRENT_HOST="$(hostname)"
TERM=xterm-256color

antibody_bundles=(
  robbyrussell/oh-my-zsh
  robbyrussell/oh-my-zsh,path:plugins/aws
  robbyrussell/oh-my-zsh,path:plugins/cargo
  robbyrussell/oh-my-zsh,path:plugins/dircycle
  robbyrussell/oh-my-zsh,path:plugins/docker
  robbyrussell/oh-my-zsh,path:plugins/docker-compose
  robbyrussell/oh-my-zsh,path:plugins/encode64
  robbyrussell/oh-my-zsh,path:plugins/extract
  robbyrussell/oh-my-zsh,path:plugins/fancy-ctrl-z
  robbyrussell/oh-my-zsh,path:plugins/httpie
  robbyrussell/oh-my-zsh,path:plugins/kubectl
  robbyrussell/oh-my-zsh,path:plugins/pip
  robbyrussell/oh-my-zsh,path:plugins/pipenv
  robbyrussell/oh-my-zsh,path:plugins/python
  robbyrussell/oh-my-zsh,path:plugins/ripgrep
  robbyrussell/oh-my-zsh,path:plugins/rsync
  robbyrussell/oh-my-zsh,path:plugins/sudo
  robbyrussell/oh-my-zsh,path:plugins/themes
  robbyrussell/oh-my-zsh,path:plugins/tmux
  robbyrussell/oh-my-zsh,path:plugins/wd
  robbyrussell/oh-my-zsh,path:plugins/zsh-interactive-cd
  robbyrussell/oh-my-zsh,path:plugins/zsh_reload
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-completions
  bhilburn/powerlevel9k,path:powerlevel9k.zsh-theme
)

export CURRENT_HOST
export TERM
export antibody_bundles

source $HOME/git/github.com/reynn/dotfiles/zsh/aliases/.reynn
source $HOME/git/github.com/reynn/dotfiles/zsh/.vars/.reynn
test -f $DFP/zsh/.hosts/.$CURRENT_HOST || source $DFP/zsh/.hosts/.$CURRENT_HOST
source $DFP/zsh/functions/.reynn
source $DFP/zsh/functions/text.zsh

export DEBUG='true'

# -----------------------------------------------------------------------------
# Antibody:Setup --------------------------------------------------------------
source <(antibody init)

# Setup required env var for oh-my-zsh plugins
export ZSH="$(antibody list | grep oh-my-zsh | awk '{print $2}')"

print_debug 'loading bundles' 'antibody'
for bundle in $antibody_bundles; do
  local sp=($(echo $bundle | tr ',' '\n'))
  print_debug "$sp" 'antibody.bundle'
  antibody bundle $sp
done

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
