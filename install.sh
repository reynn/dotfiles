GFP="$HOME/git"
DFP="$GFP/reynn/dotfiles"

# -----------------------------------------------------------------------------
# Helper functions ------------------------------------------------------------
set_uname() {
  UNAME="${$(uname):l}"
}

cecho() {
  echo -e "\033[31;1m>>\033[33mInstall\033[31m>>\033[34m$@\033[0m"
}

# -----------------------------------------------------------------------------
# Install functions -----------------------------------------------------------
install_jq() {
  if test -r /usr/local/bin/jq; then
    cecho "JQ already installed..."
  else
    cecho "Downloading JQ binary for $UNAME..."
    if test "$UNAME" == "darwin"; then
      curl -Lo jq "https://github.com/stedolan/jq/releases/download/jq-$1/jq-osx-amd64"
    elif test "$UNAME" == "linux"; then
      curl -Lo jq "https://github.com/stedolan/jq/releases/download/jq-$1/jq-osx-amd64"
    fi
    mv jq /usr/local/bin/jq
  fi
}

install_rg() {
  local url=$(echo $1 | jq '.')
  cecho "Downloading ripgrep binary..."
  curl -Lo rg $url
  mv rg /usr/local/bin/rg
}

install_fzf() {
  cecho "Running FZF install script..."
  sh -c "$GFP/junegunn/fzf/install --bin --64"
}

install_pip_packages() {
  cecho "Installing pip packages..."
  pip install Pygments yq
}

install_repos() {
  cecho "Cloning dotfiles repo..."
  git clone --depth=20 https://github.com/reynn/dotfiles.git "$DFP"
  cecho "Cloning oh-my-zsh repo..."
  git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "$GFP/robbyrussell/oh-my-zsh"
  cecho "Cloning fzf repo..."
  git clone --depth=1 https://github.com/junegunn/fzf.git "$GFP/junegunn/fzf"
}

function main() {
  if [ ! -d "$DFP" ]; then
    # local pip_path=""
    if [[ $(which pip > /dev/null) -eq 1 ]]; then
      cecho "Pip is not installed, please correct."
      exit 1
    fi
    install_repos
    cecho "Sourcing dotfiles .zshrc..."
    source $DFP/zsh/.zshrc
    install_jq
    install_pip_packages
    cd "$DFP"
    cecho "Including custom gitconfig"
    echo -n "[include]\n  path = $DFP/git/gitconfig" >> $HOME/.gitconfig
    cecho "Creating .zshrc symlink..."
    ln -s -n $DFP/zsh/.zshrc $HOME/.zshrc
  else
    cecho "Re-linking .zshrc..."
    ln -sfn $DFP/zsh/.zshrc $HOME/.zshrc
  fi
}

main
