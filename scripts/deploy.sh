#!/bin/bash
set -ue

DOTFILES=$(cd "$(dirname "$0")/.." && pwd)

# リポジトリ内のファイルを指定先に symlink する
# - 既存が実体ファイルの場合のみ .bk に退避する。既存が symlink の場合は
#   deploy 済みとみなして上書き（毎回退避すると、再実行時に symlink 自体が
#   .bk へ移動して初回の実体バックアップを潰してしまうため）
# - ln の -n はリンク先がディレクトリ symlink のとき必須。
#   これがないと再実行時にリンク先ディレクトリの「中に」新しいリンクを作ってしまう
link() {
  local src="$DOTFILES/$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$dest.bk"
  fi

  ln -snfv "$src" "$dest"
}

# --- $HOME 直下 ---
link config/zsh/.zshenv           "$HOME/.zshenv"
link config/zsh/.zshrc            "$HOME/.zshrc"
link config/zsh/.zprofile         "$HOME/.zprofile"
link config/git/.gitconfig        "$HOME/.gitconfig"
link config/git/.gitignore_global "$HOME/.gitignore_global"
link config/git/.gitmessage       "$HOME/.gitmessage"
link config/npm/.npmrc            "$HOME/.npmrc"
link config/tmux/.tmux.conf       "$HOME/.tmux.conf"
link config/vim/.vimrc            "$HOME/.vimrc"
# p10k configure 由来のコードを取り込み保守しているため ~/.p10k.zsh に配置
link config/p10k/p10k.zsh         "$HOME/.p10k.zsh"

# --- XDG (~/.config) 配下 ---
# zsh の分割ファイル (aliases.zsh 等) はディレクトリごと symlink し、.zshrc から source する
link config/zsh/rc                 "$HOME/.config/zsh"
link config/sheldon/plugins.toml   "$HOME/.config/sheldon/plugins.toml"
link config/sesh/sesh.toml         "$HOME/.config/sesh/sesh.toml"
link config/lazygit/config.yml     "$HOME/.config/lazygit/config.yml"
link config/herdr/config.toml      "$HOME/.config/herdr/config.toml"
link config/herdr/hunk-diff.sh     "$HOME/.config/herdr/hunk-diff.sh"
link config/hunk/config.toml       "$HOME/.config/hunk/config.toml"
link config/zed/settings.json      "$HOME/.config/zed/settings.json"

# .gitconfig.local は端末固有の設定 (メールアドレス等) なので symlink せず初回のみコピー
if [[ ! -f "$HOME/.gitconfig.local" ]]; then
  cp "$DOTFILES/config/git/.gitconfig.local.sample" "$HOME/.gitconfig.local"
fi
