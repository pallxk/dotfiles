#!/bin/sh
basedir=`dirname "$0"`

for list in linux cygwin; do
	"$basedir/install-packages.sh" "apt-cyg install" "$basedir/$list.txt"
done
