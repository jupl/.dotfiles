#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

install_deps

if ! which emacs &>/dev/null; then
  echo '!!! Emacs is not available'
  exit
fi

echo '--- Add eterm-color.ti to terminfo'
if [[ "$OS" == macos ]]; then
  tic /Applications/Emacs.app/Contents/Resources/etc/e/eterm-color.ti
else
  tic $(find /usr/share/emacs -name 'eterm-color.ti' | tail -n 1)
fi
