#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

if [[ "$OS" != void ]]; then
  echo '!!! This script is only available for Void Linux'
  exit 1
fi

echo '--- Setting up xbps'
sudo xbps-install -Suv

install_deps
