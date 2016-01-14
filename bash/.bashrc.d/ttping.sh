# ping and set round-trip time as terminal title
ttping () {
	# Pass on arguments to ping
	ping "$@" \
	| tee >(
		# Parse output of ping
		grep --line-buffered -Po '(?<=time.).+ms' \
		| while read; do
			# Set terminal title.
			# Redirect escape sequences to stderr,
			# so that terminal title is set in time,
			# even if output of this function is piped.
			>&2 echo -ne "\e]0;$REPLY\a"
		done
	)
}
