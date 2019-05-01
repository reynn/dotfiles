# zmodload zsh/zprof # uncomment to debug performance issues with zsh startup
export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=3

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv go_version status dir_writable)
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

plugins=()

test -e $(which kubectl > /dev/null) && plugins+=('kubectl')
test -e $(which aws > /dev/null) && plugins+=('aws')
test -e $(which docker > /dev/null) && plugins+=('docker')
test -e $(which git > /dev/null) && plugins+=('git')

source $ZSH/oh-my-zsh.sh

imports=(.aliases.sh .bindings.sh .exports.sh .functions.sh .fzf.zsh)

for f in $imports
do
  test -e && source $HOME/$f
done

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

test -e ~/.fzf.zsh && source ~/.fzf.zsh

# zprof # uncomment to debug performance issues with zsh startup
