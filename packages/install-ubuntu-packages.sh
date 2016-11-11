#!/bin/sh
basedir=`dirname "$0"`


# Node.js
#curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -


for list in linux ubuntu; do
	"$basedir/install-packages.sh" "apt-get install -y" "$basedir/$list.txt" true
done