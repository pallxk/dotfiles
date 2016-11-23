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
	fi

	# Execute the original command with defaults inserted
	command git $command "$@" "${defaults[@]}"
}
