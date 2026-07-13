# dotfiles

## Structure

```
dotfiles/
├── config/          # ツールごとの設定ファイル（scripts/deploy.sh が symlink を張る）
│   ├── zsh/         #   .zshrc / .zprofile / rc/（分割ファイル → ~/.config/zsh）
│   ├── git/         #   .gitconfig / .gitignore_global / .gitmessage / .gitconfig.local.sample
│   ├── tmux/
│   ├── vim/
│   ├── npm/
│   ├── p10k/        #   → ~/.p10k.zsh
│   ├── sheldon/     #   → ~/.config/sheldon
│   ├── sesh/        #   → ~/.config/sesh
│   ├── lazygit/     #   → ~/.config/lazygit
│   ├── herdr/       #   → ~/.config/herdr
│   └── iterm/       #   symlink 対象外（iTerm2 から手動インポート）
├── scripts/
│   ├── deploy.sh    # symlink の作成（設定の反映）
│   ├── setup.sh     # bootstrap（Homebrew / Brewfile / TPM / macOS defaults）
│   ├── set-defaults.sh
│   └── setup-gpg.sh
└── Brewfile
```

設定ファイルを追加するときは `config/<tool>/` にファイルを置き、`scripts/deploy.sh` の対応表に `link` を1行足す。

## Install

```bash
# 新しいマシンの初期構築（Homebrew / Brewfile / TPM / macOS defaults / GPG）
./scripts/setup.sh

# 設定ファイルの symlink を作成・更新（何度でも実行可）
./scripts/deploy.sh
```
