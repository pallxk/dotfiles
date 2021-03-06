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

# Load rc files from ".bashrc.d" and ".bashrc.d/after"
for rcfile in ~/.bashrc.d/{,after}/*.{sh,bash}; do
	test -r "$rcfile" && . "$rcfile"
done
unset rcfile
disown -ar


# Disallow existing regular files to be overwritten by redirection of output
set -o noclobber

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar


# Set up default editor
hash vim 2> /dev/null && VISUAL=vim || VISUAL=vi
export VISUAL
export EDITOR="$VISUAL"
