#!/bin/sh
basedir=`dirname "$0"`

"$basedir/install-packages.sh" "npm install -g" "$basedir/npm.txt" true
