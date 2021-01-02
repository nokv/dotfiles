#!/bin/bash
set -ue

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# 配置したい設定ファイル
dotfiles=(.vimrc .zshrc)

# シンボリックリンクをホームディレクトリ直下に作成
for file in "${dotfiles[@]}"; do
    ln -svf $SCRIPT_DIR/$file ~/
done
