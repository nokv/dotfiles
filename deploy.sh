#!/bin/bash
set -ue

SCRIPT_DIR=$(
  cd $(dirname $0)
  pwd
)

# 配置したい設定ファイル
dotfiles=(.vimrc .zshrc .gitconfig .gitignore_global .zimrc .gitmessage)

# シンボリックリンクをホームディレクトリ直下に作成
for file in "${dotfiles[@]}"; do
  # create backup file
  if [ -e $HOME/$file ]; then
    mv $HOME/$file $HOME/$file.bk
  fi
  ln -svf $SCRIPT_DIR/$file ~/
done
