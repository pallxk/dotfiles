#!/bin/sh
# Stow various packages, and do necessary setup.

# Exit if 'stow' not installed
if ! hash stow 2> /dev/null; then
	>&2 echo 'stow' not installed. Exiting.
	exit 1
fi

dirname="$(dirname $0)"


# Stow various packages (stow 'bash' last)
dirs="gem git readline shell ssh tig tmux vim xdg"

for dir in $dirs; do
	stow "$dir" -d "$dirname" -t ~
done


# Do necessary setup
setups="filesystem git ssh"

for setup in $setups; do
	"$dirname/$setup-setup.sh"
done


# Stow 'bash' last as it requires 'filesystem-setup.sh'
stow bash -d "$dirname" -t ~
