#!/bin/sh

# SSH requires strict permissions on files and dirs
umask 077

# Create ~/.ssh and ~/.ssh/config if not existing
mkdir -p ~/.ssh
touch ~/.ssh/config

dirname=$(realpath "$(dirname "$0")")
cd "$dirname"
identifier=$(basename "$dirname")

# Append/Replace generic ssh config block to ~/.ssh/config
if hash perl 2> /dev/null; then
	perl -0777 -pi -e \
		s%"(####### $identifier\n.+#######/$identifier\n|$)"%'`cat ssh/.ssh/ssh_config`'%se \
		~/.ssh/config
else
	cat ssh/.ssh/ssh_config >> ~/.ssh/config
fi
