#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

if [[ "$OS" != alpine ]]; then
  echo '!!! This script is only available for Alpine'
  exit 1
fi

echo '--- Setting up apk'
# TODO add community package by modifying /etc/apk/repositories
sudo apk update
sudo apk upgrade

install_deps
