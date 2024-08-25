#!/bin/sh

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Dock
defaults write com.apple.dock autohide -bool "true"
defaults write com.apple.dock show-recents -bool "false"
defaults write com.apple.dock tilesize -int "40"

# screenshots
defaults write com.apple.screencapture location -string "${HOME}/Desktop/screenshot"
defaults write com.apple.screencapture name "ScreenShot"
defaults write com.apple.screencapture disable-shadow -bool "true"
defaults write com.apple.screencapture show-thumbnail -bool "true"

# Finder
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool "true"
# Show files with all extensions
defaults write -g AppleShowAllExtensions -bool "true"
# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool "true"

# Keyboard
defaults write com.apple.inputmethod.Kotoeri JIMPrefLiveConversionKey -bool "false"
defaults write com.apple.HIToolbox AppleFnUsageType -int "0"

# .DS_Store
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool "true"
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool "true"

# report
defaults write com.apple.CrashReporter DialogType -string "none"
defaults write com.apple.appleseed.FeedbackAssistant "Autogather" -bool "false"
