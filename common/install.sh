#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

# Preinstall
case $OS in
  debian | ubuntu)
    echo '--- Setting up apt'
    sudo apt-get update
    sudo apt-get -y upgrade
    ;;
esac

install_deps

# Postinstall
case $OS in
  debian | ubuntu)
    if [ ! -e "$HOME/.fonts/texlive" ]; then
      echo '--- Symlinking fonts'
      mkdir -p $HOME/.fonts
      ln -s /usr/share/texlive/texmf-dist/fonts $HOME/.fonts/texlive
      fc-cache
    fi
    ;;
esac
