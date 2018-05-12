#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

if [[ "$OS" == macos ]] && ! which pygmentize &>/dev/null; then
  echo '--- Installing pygments'
  sudo easy_install pygments
fi

install_deps

packages=(
  beamertheme-metropolis
  capt-of
  framed
  fvextra
  ifplatform
  minted
  pgfopts
  wrapfig
  xstring
)

if ! (tlmgr list --only-installed ${packages[*]} | egrep 'installed:[[:space:]]*No') &>/dev/null; then
  exit
fi

echo '--- Downloading TeX dependencies'
tlmgr init-usertree
tlmgr --usermode update --self --all
tlmgr --usermode install ${packages[*]}
