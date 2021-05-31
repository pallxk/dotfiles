## Autorun tmux for SSH sessions

# SHLVL=1 ensures we don't auto run tmux in nested sessions, which also avoids
# infinite loop when ssh into self.
if [[ $SSH_TTY ]] && [[ $SHLVL -eq 1 ]]; then
	if [[ -z $TMUX ]] && hash tmux 2> /dev/null; then
		# Attach to existing session or create a new one.
		tmux new-session -A
	fi
fi
