# Load Git completion script
if [ -f /usr/share/git/completion/git-completion.bash ]; then
    . /usr/share/git/completion/git-completion.bash
fi

# Git alias 'g' completion
if type __git_complete > /dev/null 2>&1; then
	__git_complete g git
fi

# Proxy git to insert default options

# Only source this if git installed
command -v git > /dev/null || return

git () {
	# Get the command of git
	local command="$1"
	shift

	# Init default options as an array
	local defaults=()

	# git p4
	if [ "$command" = "p4" -a $# -gt 0 ]; then
		# "--verbose" cannot be used with "--help"
		if [[ $* != *--help* ]]; then
			defaults=("--verbose")
		fi

	# git cd
	elif [ "$command" = "cd" -a $# -eq 0 ]; then
		cd "$(git rev-parse --show-toplevel)"
		return

	# git lfs
	elif [ "$command" = "lfs" ]; then
		# Use Git built for Windows on Cygwin when working with LFS
		if [[ $(uname -s) = CYGWIN* ]]; then
			local git="$(type -pa git | grep ^/cygdrive/ | head -1)"
			if [ "$git" ]; then
				"$git" "$command" "$@"
				return
			fi
		fi
	fi

	# Execute the original command with defaults inserted
	command git $command "$@" "${defaults[@]}"
}
