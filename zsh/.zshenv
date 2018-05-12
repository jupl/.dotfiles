export DOTFILES=$(cd "$HOME/$(dirname "$(readlink $HOME/.zshenv)")" && cd .. && pwd)
source "$DOTFILES/helpers"

cleanup_helpers

# Load env files
typeset -U config_files
config_files=($DOTFILES/**/*.zsh)
for file in ${(M)config_files:#*/env.zsh}; do
  source "$file"
done
unset config_files

# Load .local file at the end for post configurations
if [ -e "$HOME/.zshenv.local" ]; then
  source "$HOME/.zshenv.local"
fi
