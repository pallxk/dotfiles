# Use regular Windows build of p4 from inside of Cygwin

# Only source this if p4 installed
command -v p4 > /dev/null || return;

# Only source this on Cygwin
command -v cygpath > /dev/null || return;

p4 () {
	PWD=$(cygpath -wa .) command p4 "$@"
}
