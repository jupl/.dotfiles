#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

install_deps

if ! which emacs &>/dev/null; then
  echo '!!! Emacs is not available'
  exit
fi

if [[ "$OS" == macos ]]; then
  echo '--- macOS specific enhancements'
  if [[ ! -e /Application/Emacs.app ]]; then
    ln -s /usr/local/opt/emacs-mac/Emacs.app /Application/Emacs.app
  fi
  defaults write org.gnu.Emacs HideDocumentIcon YES
fi

echo '--- Add eterm-color.ti to terminfo'
if [[ "$OS" == macos ]]; then
  tic /Applications/Emacs.app/Contents/Resources/etc/e/eterm-color.ti
else
  tic $(find /usr/share/emacs -name 'eterm-color.ti' | tail -n 1)
fi
