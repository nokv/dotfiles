#!/bin/sh

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# screenshots
defaults write com.apple.screencapture location -string "${HOME}/Desktop/screenshot"
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture name "ScreenShot"

