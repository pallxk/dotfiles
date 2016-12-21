#!/bin/sh

# Create folder structure beforehand, so that dotfiles in different repos can
# be stowed together.
[ -e ~/.bashrc.d/after ] || mkdir -p ~/.bashrc.d/after

# Create XDG user dirs
hash xdg-user-dirs-update 2> /dev/null && xdg-user-dirs-update
