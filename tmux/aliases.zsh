if (( $+commands[tmux] )); then
  function tmuxn  { tmux new-window "$*"; }
  function tmuxs  { tmux split-window -v -c '#{pane_current_path}' "$*"; }
  function tmuxsf { tmux split-window -v -f -c '#{pane_current_path}' "$*"; }
  function tmuxv  { tmux split-window -h -c '#{pane_current_path}' "$*"; }
  function tmuxvf { tmux split-window -h -f -c '#{pane_current_path}' "$*"; }
fi
