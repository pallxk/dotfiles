#!/bin/sh
basedir=`dirname "$0"`


# Node.js
if [ ! -e /etc/apt/sources.list.d/nodesource.list ]; then
	DISTRO="$(lsb_release -s -c)"
	# Node.js v7 is not supported on trusty
	if [ "$DISTRO" = "trusty" ]; then
		curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
	else
		curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
	fi
fi


for list in linux ubuntu; do
	"$basedir/install-packages.sh" "apt-get install -y" "$basedir/$list.txt" true
done
