if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 分割ファイルの実体は dotfiles/config/zsh/rc。deploy.sh が ~/.config/zsh に symlink する
# （リポジトリのパスを直接参照しないことで、clone 先の場所に依存しなくなる）
ZSH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

source $ZSH_CONFIG/functions.zsh
source $ZSH_CONFIG/options.zsh
source $ZSH_CONFIG/path.zsh
source $ZSH_CONFIG/plugins.zsh
source $ZSH_CONFIG/completion.zsh
source $ZSH_CONFIG/prompt.zsh
source $ZSH_CONFIG/aliases.zsh
source $ZSH_CONFIG/history.zsh

if [ -e $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi
