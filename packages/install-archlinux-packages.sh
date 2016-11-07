#!/bin/sh
basedir=`dirname "$0"`

for list in linux archlinux; do
	"$basedir/install-packages.sh" "pacman -S --needed --noconfirm" "$basedir/$list.txt" true
done
