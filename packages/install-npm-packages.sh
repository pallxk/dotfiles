#!/usr/bin/env bash

# Install all packages specified in npm.txt globally.

PKG_LIST=$(dirname $0)/npm.txt

# No not continue if file not found
[ -f "$PKG_LIST" ] || exit 1

[ $UID -ne 0 ] && sudo=sudo

while read pkg || [ "$pkg" ]; do
	# Ignore empty lines
	[ "$pkg" ] || continue
	# Ignore lines beginning with a hash (#)
	[ "${pkg:0:1}" = \# ] && continue
	$sudo npm install -g $pkg
done < "$PKG_LIST"
