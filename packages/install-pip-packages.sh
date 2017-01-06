#!/bin/sh
basedir=`dirname "$0"`

"$basedir/install-packages.sh" "pip install" "$basedir/pip.txt" true
