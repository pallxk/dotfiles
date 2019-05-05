# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Autorun
## Autorun ssh-agent
if [[ -z $SSH_AUTH_SOCK ]] && hash ssh-agent 2> /dev/null; then
	# A login shell has its first character of argument zero as a -,
	# remove that when executed as a subprocess of the ssh-agent.
	exec ssh-agent "${0#-}" "$@"
fi

# Load rc files from .bashrc.d
if test -d ~/.bashrc.d/; then
	for rcfile in ~/.bashrc.d/*.{sh,bash}; do
		test -r "$rcfile" && . "$rcfile"
	done
	unset rcfile
fi
# Load rc files from .bashrc.d/after
if test -d ~/.bashrc.d/after/; then
	for rcfile in ~/.bashrc.d/after/*.{sh,bash}; do
		test -r "$rcfile" && . "$rcfile"
	done
	unset rcfile
fi


# A Better Bash History
# =====================

# Perform history expansion on the current line and insert a space
bind 'Space: magic-space'
# Append to the history file, instead of overwriting it
shopt -s histappend
# Ignore lines matching the previous entry (ignoredups)
# Ignore lines which begin with a space character (ignorespace)
HISTCONTROL=ignoreboth
# The maximum number of lines contained in the history file
HISTFILESIZE=100000
# The number of commands to remeber in the command history
HISTSIZE=10000
# Write time stamps to the history file, but not displaying them
HISTTIMEFORMAT=
# Write time stamps to the history file, and format them when displaying
HISTTIMEFORMAT='%m-%d %H:%M '


# Disallow existing regular files to be overwritten by redirection of output
set -o noclobber

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Set up default editor
hash vim 2> /dev/null && VISUAL=vim || VISUAL=vi
export VISUAL
export EDITOR="$VISUAL"

# UnZip and ZipInfo environment options
export UNZIP='-O CP936'
export ZIPINFO='-O CP936'
