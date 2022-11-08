#!/bin/sh

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# screenshots
defaults write com.apple.screencapture location -string "${HOME}/Desktop/screenshot"
defaults write com.apple.screencapture name "ScreenShot"
defaults write com.apple.screencapture disable-shadow -bool true

# Finder
defaults write com.apple.Finder FXPreferredViewStyle Nlsv
defaults write com.apple.finder AppleShowAllFiles -bool YES
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool "true"

# .DS_Store
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool "true"
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool "true"

# report
defaults write com.apple.CrashReporter DialogType -string "none"
defaults write com.apple.appleseed.FeedbackAssistant "Autogather" -bool "false"
