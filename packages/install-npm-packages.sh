#!/usr/bin/env bash

# Install all packages specified in npm.txt globally.

PKG_LIST=$(dirname $0)/npm.txt

# No not continue if file not found
[ -f "$PKG_LIST" ] || exit 1

[ $UID -ne 0 ] && sudo=sudo

for pkg in $(cat "$PKG_LIST"); do
	$sudo npm install -g $pkg
done
