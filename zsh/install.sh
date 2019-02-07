#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

install_deps

if ! which zsh &>/dev/null; then
  echo '!!! ZSH is not available'
  exit
fi

if [[ "$OS" == macos ]] && ! (chsh -l | grep "$(which zsh)" &>/dev/null); then
  echo '--- Adding Homebrew zsh to /etc/shells'
  echo "$(which zsh)" | sudo tee -a /etc/shells >/dev/null
fi

if ! echo $SHELL | grep zsh$ &>/dev/null; then
  echo '--- Changing shell to zsh'
  chsh -s "$(cat /etc/shells | grep zsh | tail -n 1)" >/dev/null
fi

if ! which antibody &>/dev/null; then
  echo '--- Installing antibody'
  curl -sL https://git.io/antibody | bash -s
fi
