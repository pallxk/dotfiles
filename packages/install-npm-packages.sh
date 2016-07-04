#!/usr/bin/env bash

[ "$DEBUG" = 2 ] && set -x

# Install all packages specified in npm.txt globally.

PKG_LIST=$(dirname $0)/npm.txt
[ "$DEBUG" = 1 ] && echo "PKG_LIST=$PKG_LIST"

# No not continue if file not found
[ -f "$PKG_LIST" ] || exit 1

# If not running as root and sudo is available, use that
[ $UID -ne 0 ] && $(hash sudo 2> /dev/null) && sudo=sudo
[ "$DEBUG" = 1 ] && echo "sudo=$sudo"

while read pkg || [ "$pkg" ]; do
	[ "$DEBUG" = 1 ] && echo "pkg=$pkg"

	# Ignore empty lines
	[ "$pkg" ] || continue
	# Ignore lines beginning with a hash (#)
	[ "${pkg:0:1}" = \# ] && continue

	cmd="$sudo npm install -g $pkg"
	[ "$DEBUG" = 1 ] && echo "cmd=$cmd"
	$cmd
done < "$PKG_LIST"
