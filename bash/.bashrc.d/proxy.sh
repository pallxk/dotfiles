# Export various "protocol_proxy" variables,
# using one of existing *_proxy variable if available,
# otherwise, using the default value: 'http://127.0.0.1:8080/'.
function proxy_on() {
	# all
	if [ "$1" ]; then
		all_proxy=$1
	elif [[ -z $all_proxy ]]; then
		if [[ $http_proxy ]]; then
			all_proxy=$http_proxy
		elif [[ $https_proxy ]]; then
			all_proxy=$https_proxy
		else
			if nc -z 127.0.0.1 6152 2> /dev/null; then
				all_proxy=http://127.0.0.1:6152/
			else
				all_proxy=http://127.0.0.1:8080/
			fi
			# Cygwin
			[[ `uname -s` == CYGWIN* ]] && all_proxy=http://127.0.0.1:1080/
		fi
	fi
	# http
	if [[ -z $http_proxy ]]; then
		http_proxy=$all_proxy
	fi
	# https
	if [[ -z $https_proxy ]]; then
		https_proxy=$all_proxy
	fi
	# ftp
	if [[ -z $ftp_proxy ]]; then
		ftp_proxy=$all_proxy
	fi
	# exceptions
	if [[ -z $no_proxy ]]; then
		no_proxy="localhost,127.0.0.1"
	fi

	export http_proxy https_proxy ftp_proxy all_proxy no_proxy
}

function proxy_off() {
	export -n http_proxy https_proxy ftp_proxy all_proxy no_proxy
	export -n HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY NO_PROXY
}
