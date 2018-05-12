if (( $+commands[go] )); then
  export PATH="$PATH:$(go env GOPATH)/bin"
elif [[ -e "$HOME/.local/share/umake/go/go-lang/bin" ]]; then
  export PATH="$PATH:$HOME/.local/share/umake/go/go-lang/bin"
fi
