#!/bin/sh

echo $PWD

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

brew bundle --file ./Brewfile

# create directories
mkdir ~/Desktop/screenshot
mkdir ~/Desktop/develop

sh $PWD/macos/set-defaults.sh
sh $PWD/macos/setup-gpg.sh

echo Done!
