#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

if [[ "$OS" == macos ]] || [[ -z "$GUI" ]]; then
  echo '!!! This script is only available for Linux with GUI'
  exit 1
fi

install_deps

if ! which awesome &>/dev/null; then
  echo '!!! awesome is not available'
  exit
fi
