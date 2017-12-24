#!/bin/sh
basedir=`dirname "$0"`

"$basedir/install-packages.sh" "yarn global add" "$basedir/npm.txt"
