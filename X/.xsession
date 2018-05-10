#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

[[ -f ~/.extend.xsession ]] && . ~/.extend.xsession

# Setup $PATH
[[ -f ~/.bash_profile.d/path.sh ]] && . ~/.bash_profile.d/path.sh

# Start ssh-agent
if [[ -z $SSH_AUTH_SOCK ]] && hash ssh-agent 2> /dev/null; then
	eval `ssh-agent`
fi

# Start IBus
ibus-daemon -drx
