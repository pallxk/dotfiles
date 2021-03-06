#!/bin/sh

# Create folder structure beforehand, so that dotfiles in different repos can
# be stowed together.
dirs="$HOME/.bashrc.d/after $HOME/bin/after $HOME/.config $HOME/vim.tmp"

for dir in $dirs; do
	[ -e "$dir" ] || mkdir -p "$dir"
done


# Create XDG user dirs
hash xdg-user-dirs-update 2> /dev/null && xdg-user-dirs-update
