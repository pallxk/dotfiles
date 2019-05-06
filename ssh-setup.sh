#!/bin/sh

# SSH requires strict permissions on files and dirs
umask 077

# Create ~/.ssh and ~/.ssh/config if not existing
mkdir -p ~/.ssh
touch ~/.ssh/config

dirname=$(realpath "$(dirname "$0")")
cd "$dirname"
identifier=$(basename "$dirname")
LF=$'\n'
export BLOCK_BEGIN="$LF####### $identifier$LF$LF"
export BLOCK_END="$LF#######/$identifier$LF$LF"

# Append/Replace generic ssh config block to ~/.ssh/config
if hash perl 2> /dev/null; then
	perl -0777 -pi -e \
		s%"($BLOCK_BEGIN.+$BLOCK_END|$)"%'$ENV{BLOCK_BEGIN}.`cat ssh/.ssh/ssh_config`.$ENV{BLOCK_END}'%es \
		~/.ssh/config
else
	(
		echo -n "$BLOCK_BEGIN"
		cat ssh/.ssh/ssh_config
		echo -n "$BLOCK_END"
	) >> ~/.ssh/config
fi
