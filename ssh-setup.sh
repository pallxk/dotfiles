#!/bin/sh
# Because of the potential for abuse, other users shall have no permissions
umask 077
# Create ~/.ssh direcotry if not existing
test -d ~/.ssh || mkdir ~/.ssh
# Import generic ssh config into ~/.ssh/config
dirname=`dirname "$0"`
cat "$dirname/ssh/.ssh/ssh_config" >> ~/.ssh/config
