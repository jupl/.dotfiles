if (( $+commands[emacs] )); then
  emacs() {
    server=server
    if [[ -n "$DISPLAY" ]] || [[ "$OS" == macos ]]; then
      server=gui
    fi
    emacsclient -s $server --eval t &>/dev/null
    if [[ $? -ne 0 ]]; then
      if [[ "$server" != gui ]]; then
        command emacs --daemon=$server
        emacsclient -s $server -c $@
      elif [[ "$OS" == macos ]]; then
        open -a Emacs $@
      else
        command emacs $@ &>/dev/null &!
      fi
    elif [[ "$server" != gui ]]; then
      emacsclient -s $server -c $@
    else
      emacsclient -s $server -c $@ &!
    fi
  }
  magit() {
    emacs --eval "(magit-status \"${1:-$PWD}\")"
  }
fi
