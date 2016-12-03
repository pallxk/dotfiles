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
## (Do not auto run tmux on Cygwin as it takes a long time before response)
if [[ $(uname -s) != CYGWIN* ]]; then
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
#shopt -s globstar


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Set prompt string
PROMPT_COMMAND=__prompt_command
__prompt_command () {
	# Remember the exit code of last command or it will get overwritten here
	local ret=$?

	# No 'xtrace' for PROMPT_COMMAND, restore it before return
	[[ $- = *x* ]] && set +x && local xtrace=1

	local color_prompt force_color_prompt

	# uncomment for a colored prompt, if the terminal has the capability;
	# turned off by default to not distract the user: the focus in a
	# terminal window should be on the output of commands, not on the prompt
	force_color_prompt=yes

	if [ -n "$force_color_prompt" ]; then
	    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	    fi
	else
		# set a fancy prompt (non-color, unless we know we "want" color)
		case "$TERM" in
		    xterm-color) color_prompt=yes;;
		esac
	fi

	# set variable identifying the chroot you work in (used in the prompt below)
	if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	    debian_chroot=$(cat /etc/debian_chroot)
	fi

	local username hostname pwd code sign

	if [ "$color_prompt" = yes ]; then
		username='\[\033[01;32m\]\u\[\033[00m\]'
		     pwd='\[\033[01;34m\]\w\[\033[00m\]'
		    sign='\$\[\033[00;32m\]'

		if [ "$SSH_TTY" ]; then
			hostname='\[\033[01;32m\]@\h\[\033[00m\]'
		fi

		if [ $ret -ne 0 ]; then
			code='\[\033[01;31m\]($?)\[\033[00m\] '
		fi

		PS1="${debian_chroot:+($debian_chroot)}${username}${hostname} ${pwd} ${code}${sign} "
		# Remove color settings for command string before executing it
		trap 'printf "\033[00m"' DEBUG
	else
		username='\u'
		     pwd='\w'
		    sign='\$'

		if [ "$SSH_TTY" ]; then
			hostname='@\h'
		fi

		if [ $ret -ne 0 ]; then
			code='($?) '
		fi

		PS1="[${debian_chroot:+($debian_chroot)}${username}${hostname} ${pwd}]${code}${sign} "
	fi

	# If this is an xterm set the title to user@host:dir
	case "$TERM" in
		xterm*|rxvt*)
		    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
		    ;;
		*)
		    ;;
	esac

	# Restore 'xtrace' shell option
	[ "${xtrace}" ] && set -x
}


# Set up default editor
hash vim 2> /dev/null && VISUAL=vim || VISUAL=vi
export VISUAL
export EDITOR="$VISUAL"

# UnZip and ZipInfo environment options
export UNZIP='-O CP936'
export ZIPINFO='-O CP936'
