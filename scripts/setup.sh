#!/bin/bash
set -eu

DOTFILES=$(cd "$(dirname "$0")/.." && pwd)

sudo -v

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # インストール直後は brew が PATH に入っていない (Apple Silicon では /opt/homebrew 配下)
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update
brew bundle --file "$DOTFILES/Brewfile"

mkdir -p ~/Desktop/screenshot ~/Desktop/develop

# TPM (tmux plugin manager)
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# GPG の pinentry を pinentry-mac にする
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg
pinentry_line="pinentry-program $(command -v pinentry-mac)"
if ! grep -qxF "$pinentry_line" ~/.gnupg/gpg-agent.conf 2>/dev/null; then
  echo "$pinentry_line" >> ~/.gnupg/gpg-agent.conf
fi
gpgconf --kill gpg-agent

sh "$DOTFILES/scripts/set-defaults.sh"

"$DOTFILES/scripts/deploy.sh"

echo "Done!"
