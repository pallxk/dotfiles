#!/usr/bin/env bash

# Create folder structure beforehand, so that dotfiles in different repos can
# be stowed together.
dirs=(
	$HOME/.bashrc.d/after
	$HOME/bin/after
	$HOME/.config/otp
	$HOME/.cache/vim/backup
	$HOME/.cache/vim/swap
	$HOME/.cache/vim/undo
)

for dir in "${dirs[@]}"; do
	[ -e "$dir" ] || mkdir -p "$dir"
done


# Create XDG user dirs
if hash xdg-user-dirs-update 2> /dev/null; then
	xdg-user-dirs-update
fi
