#!/bin/sh
basedir=`dirname "$0"`


# Node.js
if [ ! -e /etc/apt/sources.list.d/nodesource.list ]; then
	curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
fi

# Yarn
if [ ! -e /etc/apt/sources.list.d/yarn.list ]; then
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt-get update
fi

for list in linux ubuntu; do
	"$basedir/install-packages.sh" "apt-get install -y" "$basedir/$list.txt" true
done
