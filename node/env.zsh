if (( $+commands[node] )); then
  export PATH="$PATH:$HOME/.npm/bin"
elif (( $+commands[yarn] )); then
  export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"
fi
