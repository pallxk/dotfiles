#!/bin/sh
basedir=`dirname "$0"`

# Yarn
if [ ! -e /etc/yum.repos.d/yarn.repo ]; then
	sudo wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
fi

for list in rpm linux; do
	"$basedir/install-packages.sh" "yum install -y" "$basedir/$list.txt" true
done
