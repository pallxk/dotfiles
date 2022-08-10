# Set prompt string
if [ -z "$PROMPT_COMMAND" ]; then
	PROMPT_COMMAND=__prompt_command
else
	PROMPT_COMMAND="__prompt_command; ${PROMPT_COMMAND%; }; timer_clear"
fi

__prompt_command () {
	# Remember the exit code of last command or it will get overwritten here
	local ret=$?

	# No 'xtrace' for PROMPT_COMMAND, restore it before return
	if [[ $- = *x* ]]; then
		set +x
		local xtrace=1
	else
		local xtrace=
	fi

	# Calculate run time of last command
	timer_stop

	local color_prompt force_color_prompt

	# uncomment for a colored prompt, if the terminal has the capability;
	# turned off by default to not distract the user: the focus in a
	# terminal window should be on the output of commands, not on the prompt
	force_color_prompt=yes

	if [ -n "$force_color_prompt" ]; then
	    if tput setaf 1 >&/dev/null; then
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

	# https://codeberg.org/dnkl/foot#jumping-between-prompts
	prompt_marker='\[\033]133;A\033\]'

	# set variable identifying the chroot you work in (used in the prompt below)
	if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	    debian_chroot=$(cat /etc/debian_chroot)
	fi

	local username hostname pwd time code sign cmd

	if [ "$color_prompt" = yes ]; then
		username='\[\033[01;32m\]\u\[\033[00m\]'
		     pwd='\[\033[01;34m\]\w\[\033[00m\]'
		     cmd="\[\033[00;${THEME_COLOR:-32}m\]"

		# sign
		if [ "$UID" = 0 ] && [ "$HISTFILE" ]; then
			sign='\[\033[4;31m\]#\[\033[0m\]'
		elif [ "$UID" = 0 ]; then
			sign='\[\033[0;31m\]#\[\033[0m\]'
		elif [ "$HISTFILE" ]; then
			sign='\[\033[4m\]\$\[\033[0m\]'
		else
			sign='\$'
		fi

		# Remove color settings for command string before executing it
		if [ ${BASH_VERSINFO[0]} -eq 4 ] && [ ${BASH_VERSINFO[1]} -ge 4 ] || [ ${BASH_VERSINFO[0]} -gt 4 ]; then
			# Bash >= 4.4 supports PS0
			PS0="\033[00m"
		else
			# Fallback to use trap DEBUG
			debugcmd='printf "\033[00m"'
		fi

		if [ "${SSH_TTY-}" -o "${TERM_PROGRAM-}" = vscode ]; then
			hostname='\[\033[01;32m\]@\h\[\033[00m\]'
		fi

		if [ $time_diff -ge 3 ]; then
			time=' \[\033[01;33m\](${time_diff}s)\[\033[00m\]'
		else
			time=
		fi

		if [ $ret -ne 0 ]; then
			code=' \[\033[01;31m\]($?)\[\033[00m\]'
		else
			code=
		fi

		PS1="\n${prompt_marker}${debian_chroot:+($debian_chroot)}${username}${hostname-} ${pwd}${time}${code}\n${sign} ${cmd}"
	else
		username='\u'
		     pwd='\w'

		# sign
		if [ "$UID" = 0 ] && [ "$HISTFILE" ]; then
			sign='#>'
		elif [ "$UID" = 0 ]; then
			sign='#'
		elif [ "$HISTFILE" ]; then
			sign='\$>'
		else
			sign='\$'
		fi

		if [ "${SSH_TTY-}" -o "${TERM_PROGRAM-}" = vscode ]; then
			hostname='@\h'
		fi

		if [ $time_diff -ge 3 ]; then
			time=' (${time_diff}s)'
		else
			time=
		fi

		if [ $ret -ne 0 ]; then
			code=' ($?)'
		else
			code=
		fi

		PS1="\n${prompt_marker}[${debian_chroot:+($debian_chroot)}${username}${hostname-} ${pwd}]${time}${code}\n${sign} "
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

# $timer is set only when user entered command is going to be executed
timer_start () {
	timer=${timer:-$SECONDS}
}

# This is called only when $PS1 is going to be shown
timer_stop () {
	time_diff=$(($SECONDS - ${timer:-0}))
	unset timer
}

# Clear timer only
timer_clear () {
	unset timer
}

# Call once to init some variables
__prompt_command
trap "${debugcmd:-:}; timer_start" DEBUG
