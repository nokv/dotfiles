#!/bin/sh

# bashにしたら動くかも？

# PWD=$(
#   cd $(dirname $0)
#   pwd
# )

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

sh $PWD/macos/set-defaults.sh

echo Done!
