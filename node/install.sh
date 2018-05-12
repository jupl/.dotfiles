#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

case $OS in
  debian | ubuntu)
    echo '--- Adding Node.js PPA'
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    ;;
esac
install_deps

if ! which node &>/dev/null; then
  echo '!!! Node is not available'
  exit
fi

echo '--- Configuring npm defaults'
npm config set prefix "$HOME/.npm"
npm config set loglevel silent
npm config set progress false

PATH="$PATH:$HOME/.npm/bin"
if which trash &>/dev/null; then exit; fi

echo '--- Installing essential NPM packages'
if [[ "$OS" == macos ]]; then
  npm install -g alfred-lock
fi
npm install -g js-beautify jsonlint tern trash-cli
