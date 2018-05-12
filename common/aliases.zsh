# Add color highlighting
if [[ "$OS" != macos ]]; then
  alias ls='ls --color=auto'
fi
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Customized greps
alias hgrep='history 0 | grep'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'

# Additional helpers
alias la='ls -lah'
alias mkdir='mkdir -pv'
alias path='echo -e ${PATH//:/\\n}'

function dotf { (cd $DOTFILES && "$@"); }
