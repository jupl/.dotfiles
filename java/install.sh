#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

install_deps

if ! which javac &>/dev/null; then
  echo '!!! JDK is not available'
  exit
fi

if [[ ! -f ./bin/boot ]]; then
  echo '--- Installing boot'
  curl -L https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh --output ./bin/boot
  chmod +x ./bin/boot
  # Run twice to force download latest
  ./bin/boot
  ./bin/boot
fi
