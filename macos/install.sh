#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

if [[ "$OS" != macos ]]; then
  echo '!!! This script is only available for macOS'
  exit 1
fi

if ! which brew &>/dev/null; then
  echo '--- Installing Homebrew'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  if ! which brew &>/dev/null; then
    echo '!!! Failed to install Homebrew'
    exit 1
  fi
  brew tap 'homebrew/bundle'
  brew tap 'homebrew/services'
  brew tap 'caskroom/cask'
fi

install_deps

echo '--- Setting OS X preferences'
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write com.apple.Finder FXPreferredViewStyle Nlsv
chflags nohidden ~/Library
defaults write NSGlobalDomain KeyRepeat -int 0
defaults write NSGlobalDomain InitialKeyRepeat -int 0
defaults write com.apple.Safari ShowFavoritesBar -bool false
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

if [[ ! -e "$HOME/iCloud" ]]; then
  echo '--- Adding symlink to iCloud'
  ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs" "$HOME/iCloud"
fi

echo '--- Setting up for Karabiner symlink'
mkdir -p "$HOME/.config/karabiner"

echo '--- Setting up iTerm 2 configuration'
cp .iterm/com.googlecode.iterm2.plist "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
