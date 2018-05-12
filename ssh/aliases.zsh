if (( $+commands[keychain] )); then
  typeset -U keys
  keys=($HOME/.ssh/keychain/*.pub(N))
  keys=${${keys//#$HOME\/.ssh\//}//%\.pub/}
  keys="${keys[*]}"
  eval $(keychain --eval --noask --quiet $keys)
  if [[ "$keys" != '' ]]; then
    alias keychain_load="keychain $keys"
  fi
  unset keys
fi
