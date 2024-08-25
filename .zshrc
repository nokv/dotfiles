export LANG=ja_JP.UTF-8

DOTFILES=$HOME/dotfiles

source $DOTFILES/zsh/prompt.zsh
source $DOTFILES/zsh/zim.zsh
source $DOTFILES/zsh/options.zsh
source $DOTFILES/zsh/path.zsh
source $DOTFILES/zsh/completion.zsh
source $DOTFILES/zsh/aliases.zsh
source $DOTFILES/zsh/editor.zsh
source $DOTFILES/zsh/history.zsh

if [ -e $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi
