## Autorun tmux for SSH sessions
if [[ $SSH_TTY ]]; then
	if [[ -z $TMUX ]] && hash tmux 2> /dev/null; then
		printf '\ntmux session list:\n'

		if tmux ls; then
			# If tmux sessions exist, just display the session list.
			echo
		else
			# If no tmux sessions exist, start one.
			tmux
		fi
	fi
fi
