#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

if [[ "$OS" != ubuntu ]]; then
  echo '!!! This script is only available for Ubuntu'
  exit 1
fi

install_deps
