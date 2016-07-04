#!/bin/sh
basedir=`dirname "$0"`

"$basedir/install-packages.sh" "gem install" "$basedir/gem.txt"
