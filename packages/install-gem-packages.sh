#!/bin/sh
basedir=`dirname "$0"`

"$basedir/install-packages.sh" "gem install --user-install" "$basedir/gem.txt"
