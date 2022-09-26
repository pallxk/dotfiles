## Autorun tmux for SSH sessions

# Don't auto run tmux if no tty or ssh into localhost
if [[ $SSH_TTY ]] && [[ $SSH_CONNECTION != ::1\ * ]] && [[ $SSH_CONNECTION != 127.0.0.1\ * ]]; then
	if [[ -z $TMUX ]] && hash tmux 2> /dev/null; then
		# Attach to existing session or create a new one.
		tmux new-session -A
	fi
fi
