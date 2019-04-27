export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=3

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv status)
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  docker
  kubectl
  aws
)

source $ZSH/oh-my-zsh.sh

for f in .exports.sh .aliases.sh .functions.sh .fzf.zsh
do
  [ -f $f ] && source $f
done

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

