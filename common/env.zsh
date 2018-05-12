export PATH="$PATH:$DOTFILES/common/bin"

if (( $+commands[ssh-askpass] )); then
  export SSH_ASKPASS="$(which ssh-askpass)"
fi
