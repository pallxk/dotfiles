## Autorun tmux for SSH sessions
if [[ $SSH_TTY ]]; then
	if [[ -z $TMUX ]] && hash tmux 2> /dev/null; then
		# Attach to existing session or create a new one.
		tmux new-session -A
	fi
fi
