# Start tmux if not running already, plus verify it works
if (( $+commands[tmux] )) && [[ -z "$EMACS" ]] && [[ -z "$TMUX" ]]; then
  tmux -V >/dev/null
  if [[ $? -eq 0 ]]; then
    session=default
    if [[ -n "$SSH_CONNECTION" ]]; then
      session=ssh
    elif [[ -n "$DISPLAY" ]]; then
      session=gui
    fi
    exec tmux -2 new-session -A -s $session
    exit
  fi
fi

# Set up antibody
if (( $+commands[antibody] )); then
  export ANTIBODY_HOME="$DOTFILES/zsh/antibody"
  antibody_local="$DOTFILES/zsh/local.zsh"
  antibody_plugins="$ANTIBODY_HOME/plugins"
  if ! [[ -f "$antibody_local" ]] || [ "$antibody_plugins" -nt "$antibody_local" ]; then
    antibody bundle < "$antibody_plugins" > "$antibody_local"
  fi
fi

# Load additional zsh files
typeset -U config_files
config_files=($DOTFILES/*/*.zsh)
for file in ${config_files:#*/env.zsh}; do
  source "$file"
done
unset config_files

# Additional ZSH options
setopt histreduceblanks
setopt histignorealldups
setopt histignorespace
setopt interactivecomments

# Remap autosuggest-accept
bindkey '^ ' autosuggest-accept
bindkey '\C-j' down-line-or-search
bindkey '\C-k' up-line-or-search
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Load .local file at the end for post configurations
if [ -e "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
