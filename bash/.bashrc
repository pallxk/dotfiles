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

## Autorun tmux
if [[ -z $TMUX ]] && hash tmux 2> /dev/null; then
	printf '\ntmux session list:\n'

	if tmux ls; then
		# If tmux sessions exist, just display the session list.
		echo
	else
		# If no tmux sessions exist, start one.
		tmux
	fi
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


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W \[\033[00m\]\$ '
else
    PS1='[${debian_chroot:+($debian_chroot)}\u@\h \W]\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Set up default editor
hash vim 2> /dev/null && VISUAL=vim || VISUAL=vi
export VISUAL
export EDITOR="$VISUAL"
