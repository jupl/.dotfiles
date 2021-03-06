#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

if [[ "$OS" != ubuntu ]]; then
  echo '!!! This script is only available for Ubuntu'
  exit 1
fi

echo '--- Setting up apt'
sudo apt-get update
sudo apt-get -y upgrade

install_deps

# Postinstall
if [ ! -e "$HOME/.fonts/texlive" ]; then
  echo '--- Symlinking fonts'
  mkdir -p $HOME/.fonts
  ln -s /usr/share/texlive/texmf-dist/fonts $HOME/.fonts/texlive
  fc-cache
fi
