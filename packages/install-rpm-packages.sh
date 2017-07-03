#!/bin/sh
basedir=`dirname "$0"`

for list in rpm linux; do
	"$basedir/install-packages.sh" "yum install -y" "$basedir/$list.txt" true
done
