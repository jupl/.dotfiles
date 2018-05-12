#!/usr/bin/env bash

cd "$(dirname "$0")"
source ../helpers

if [[ -f $HOME/.gitconfig.local ]]; then exit; fi

echo '--- Gathering localized Git configuration data'
credential_helper=cache
if [[ "$OS" == macos ]]; then
  credential_helper=osxkeychain
fi
printf '[git] user.name: '
read -e user_name
printf '[git] user.email: '
read -e user_email

echo '--- Building .gitconfig.local'
sed \
  -e "s/USER_NAME/$user_name/g" \
  -e "s/USER_EMAIL/$user_email/g" \
  -e "s/CREDENTIAL_HELPER/$credential_helper/g" \
  .gitconfig.local.example > $HOME/.gitconfig.local
