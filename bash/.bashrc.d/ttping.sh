# ping and set round-trip time as terminal title
ttping () {
	# Pass on arguments to ping
	ping "$@" \
	| tee >(
		# Regex for round-trip time
		#  Linux style: 'time=42 ms', 'time=0 ms'
		#  Windows style: 'time=42ms', 'time<1ms'
		local time='(?<=time.).+ms'
		# Regex for unreachable
		#  Linux style: 'Dest Unreachable'
		#  Windows style: 'Destination host unreachable.'
		local unreachable='nreachable'
		# Regex for timed out
		#  Linux style: (No Message)
		#  Windows style: 'Request timed out.'
		local timedout='timed out'

		# Title for the terminal
		local title

		# Parse output of ping
		grep --line-buffered -Po "$time|$unreachable|$timedout" \
		| while read; do
			# Set terminal title.
			# Support: bash 4.3.11 (and neighboring versions)
			# Unbalenced right parenthesis in case construct in
			# process substitution causes bug for bash scanner.
			case "$REPLY" in
				(*ms)
					title="$REPLY"
					;;
				($timedout)
					title="!! Timed out"
					;;
				($unreachable)
					title="!! Host Down"
					;;
			esac

			# Redirect escape sequences to stderr,
			# so that terminal title is set in time,
			# even if output of this function is piped.
			>&2 echo -ne "\e]0;$title\a"
		done
	)
}
