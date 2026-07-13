#!/bin/sh

# setup GPG
touch ~/.gnupg/gpg-agent.conf
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf

killall gpg-agent
gpgconf --kill gpg-agent
