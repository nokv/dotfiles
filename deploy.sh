#!/bin/bash
set -ue

DOTFILES=$(
  cd $(dirname $0)
  pwd
)

# SymLink
files=(.vimrc .zprofile .zshrc .gitconfig .gitignore_global .gitmessage .npmrc .tmux.conf)
for file in "${files[@]}"; do
  # create backup file
  if [ -e $HOME/$file ]; then
    mv $HOME/$file $HOME/$file.bk
  fi
  ln -svf $DOTFILES/$file ~/
done

if [[ ! -f "$HOME/.gitconfig.local" ]]; then
  cp "$DOTFILES/.gitconfig.local.sample" "$HOME/.gitconfig.local"
fi

# Sheldon
mkdir -p "$HOME/.config/sheldon"
ln -svf "$DOTFILES/sheldon/plugins.toml" "$HOME/.config/sheldon/plugins.toml"

# Powerlevel10k (Lean style, p10k configure 由来のコードを取り込み保守)
ln -svf "$DOTFILES/p10k/p10k.zsh" "$HOME/.p10k.zsh"

# sesh
mkdir -p "$HOME/.config/sesh"
ln -svf "$DOTFILES/sesh/sesh.toml" "$HOME/.config/sesh/sesh.toml"

# lazygit
mkdir -p "$HOME/.config/lazygit"
ln -svf "$DOTFILES/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

# herdr
mkdir -p "$HOME/.config/herdr"
ln -svf "$DOTFILES/herdr/config.toml" "$HOME/.config/herdr/config.toml"
ln -svf "$DOTFILES/herdr/hunk-diff.sh" "$HOME/.config/herdr/hunk-diff.sh"
