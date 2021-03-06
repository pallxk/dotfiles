#!/usr/bin/env bash

# SYNOPSIS
# install_packages.sh <COMMAND> <PKG_LIST> <USE_SUDO>
#
# EXAMPLES
# install_packages.sh "npm install -g" "npm.txt" true


[ "$DEBUG" = 2 ] && set -x

# Process arguments
COMMAND="$1"
PKG_LIST="$2"
USE_SUDO="$3"
if [ "$DEBUG" = 1 ]; then
	echo "COMMAND=$COMMAND"
	echo "PKG_LIST=$PKG_LIST"
	echo "USE_SUDO=$USE_SUDO"
fi

# Do not continue if file not found
[ -f "$PKG_LIST" ] || exit 1

# Exit early when killed
trap "exit 1" SIGINT SIGTERM

# Init variables
sudo=

# If not running as root and sudo is required and available, use that
if [ "$USE_SUDO" = true ] && [ $UID -ne 0 ] && $(hash sudo 2> /dev/null); then
	sudo="sudo -n"
	# Cache sudo credential
	sudo -v
fi
[ "$DEBUG" = 1 ] && echo "sudo=$sudo"

while read pkg || [ "$pkg" ]; do
	[ "$DEBUG" = 1 ] && echo "pkg=$pkg"

	# Ignore empty lines
	[ "$pkg" ] || continue
	# Ignore lines beginning with a hash (#)
	[ "${pkg:0:1}" = \# ] && continue

	cmd="$sudo $COMMAND $pkg"
	[ "$DEBUG" = 1 ] && echo "cmd=$cmd"
	$cmd < /dev/null
done < "$PKG_LIST"
