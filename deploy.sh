#!/bin/bash
set -ue

DOTFILES=$(
  cd $(dirname $0)
  pwd
)

# SymLink
files=(.vimrc .zprofile .zshrc .gitconfig .gitignore_global .zimrc .gitmessage .npmrc .yarnrc)
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
