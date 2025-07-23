#!/bin/sh
# https://macos-defaults.com/

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Dock
defaults write com.apple.dock autohide -bool "true"
defaults write com.apple.dock show-recents -bool "false"
defaults write com.apple.dock tilesize -int "40"
defaults write com.apple.dock springboard-columns -int 9
defaults write com.apple.dock springboard-rows -int 6
defaults write com.apple.dock ResetLaunchPad -bool "true"
# Restart Dock to apply changes
killall Dock

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
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
rm -rf ~/.DS_Store

# .DS_Store
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool "true"
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool "true"

killall Finder

# Keyboard
defaults write com.apple.inputmethod.Kotoeri JIMPrefLiveConversionKey -bool "false"
defaults write com.apple.HIToolbox AppleFnUsageType -int "0"
defaults write com.apple.AppleMultitouchTrackpad "FirstClickThreshold" -int "0"
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool "false"
defaults write -g NSAutomaticDashSubstitutionEnabled -bool "false"

# report
defaults write com.apple.CrashReporter DialogType -string "none"
defaults write com.apple.appleseed.FeedbackAssistant "Autogather" -bool "false"

# Desktop
defaults write com.apple.menuextra.clock ShowSeconds -bool "true"
defaults write com.apple.WindowManager "EnableStandardClickToShowDesktop" -bool false
