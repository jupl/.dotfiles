#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

if [[ "$OS" == ubuntu ]]; then
  PATH="$PATH:$HOME/.local/share/umake/go/go-lang/bin"
  if ! which go &>/dev/null; then
    echo '--- Installing Go via ubuntu-make'
    yes '' | umake go go-lang "$HOME/.local/share/umake/go/go-lang"
  fi
fi

# TODO determine best way to install Go in Debian

install_deps

if ! which go &>/dev/null; then
  echo '!!! Go is not available'
  exit
fi

echo '--- Installing essential Go binaries'
go get -u github.com/golang/dep/cmd/dep
go get -u github.com/godoctor/godoctor
go get -u github.com/nsf/gocode
go get -u github.com/rogpeppe/godef
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/gorename
go get -u golang.org/x/tools/cmd/guru
