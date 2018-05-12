#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

install_deps

# Set up .ssh and permissions
mkdir -p $HOME/.ssh/socket
chmod 700 $HOME/.ssh
