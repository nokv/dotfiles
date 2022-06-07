export LANG=ja_JP.UTF-8

SCRIPT_DIR=$HOME/dotfiles

source $SCRIPT_DIR/zsh/zim.zsh
source $SCRIPT_DIR/zsh/options.zsh
source $SCRIPT_DIR/zsh/aliases.zsh
source $SCRIPT_DIR/zsh/completion.zsh
source $SCRIPT_DIR/zsh/completion/npm.zsh
source $SCRIPT_DIR/zsh/editor.zsh
source $SCRIPT_DIR/zsh/history.zsh
source $SCRIPT_DIR/zsh/path.zsh
source $SCRIPT_DIR/zsh/prompt.zsh

if [ -e $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi
