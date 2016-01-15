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

		# Parse output of ping
		grep --line-buffered -Po "$time|$unreachable|$timedout" \
		| while read; do
			# Set terminal title.
			# Redirect escape sequences to stderr,
			# so that terminal title is set in time,
			# even if output of this function is piped.
			case "$REPLY" in
				*ms)
					>&2 echo -ne "\e]0;$REPLY\a"
					;;
				$unreachable|$timedout)
					>&2 echo -ne "\e]0;!! Host Down\a"
					;;
			esac
		done
	)
}
