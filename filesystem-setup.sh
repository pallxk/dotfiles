#!/bin/sh

# Create folder structure beforehand, so that dotfiles in different repos can
# be stowed together.
[ -e ~/.bashrc.d/after ] || mkdir -p ~/.bashrc.d/after
