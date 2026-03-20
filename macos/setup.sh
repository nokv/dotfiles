#!/bin/sh

DOTFILES_DIR=$(cd "$(dirname "$0")/.." && pwd)
echo $DOTFILES_DIR

sudo -v
cd ~

if test ! $(which brew); then
  echo "Installing Homebrew... "
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed"
  # exit 1
fi

# Update and upgrade
brew update
brew upgrade

brew bundle --file "$DOTFILES_DIR/Brewfile"

# create directories
mkdir ~/Desktop/screenshot
mkdir ~/Desktop/develop

sh "$DOTFILES_DIR/macos/set-defaults.sh"
sh "$DOTFILES_DIR/macos/setup-gpg.sh"

echo Done!
