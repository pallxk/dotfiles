#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Autorun
if [[ -z $SSH_AUTH_SOCK ]] && hash ssh-agent 2> /dev/null; then
	# A login shell has its first character of argument zero as a -,
	# remove that when executed as a subprocess of the ssh-agent.
	exec ssh-agent "${0#-}" "$@"
fi

# Load rc files from .bashrc.d
if test -d .bashrc.d/; then
	for rcfile in .bashrc.d/*.sh; do
		test -r "$rcfile" && . "$rcfile"
	done
	unset rcfile
fi
# Load rc files from .bashrc.d/after
if test -d .bashrc.d/after/; then
	for rcfile in .bashrc.d/after/*.sh; do
		test -r "$rcfile" && . "$rcfile"
	done
	unset rcfile
fi


# A Better Bash History
# =====================

# Append to the history file, instead of overwriting it
shopt -s histappend
# Ignore lines matching the previous entry (ignoredups)
# Ignore lines which begin with a space character (ignorespace)
HISTCONTROL=ignoreboth
# The maximum number of lines contained in the history file
HISTFILESIZE=10000
# The number of commands to remeber in the command history
HISTSIZE=2000
# Write time stamps to the history file, but not displaying them
HISTTIMEFORMAT=
# Write time stamps to the history file, and format them when displaying
HISTTIMEFORMAT='%m-%d %H:%M '


PS1='[\u@\h \W]\$ '

# Set up default editor
hash vim 2> /dev/null && VISUAL=vim || VISUAL=vi
export VISUAL
export EDITOR="$VISUAL"
