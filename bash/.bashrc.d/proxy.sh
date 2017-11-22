# Export various "protocol_proxy" variables,
# using corresponding uppercase or lowercase variable values if available,
# otherwise, using the default value: 'http://127.0.0.1:8080/'.
function proxy_on() {
	# http
	if [[ -z $http_proxy && -z $HTTP_PROXY ]]; then
		http_proxy=http://127.0.0.1:8080/
		HTTP_PROXY=$http_proxy
	elif [[ -z $http_proxy ]]; then
		http_proxy=$HTTP_PROXY
	elif [[ -z $HTTP_RPOXY ]]; then
		HTTP_PROXY=$http_proxy
	fi
	# https
	if [[ -z $https_proxy && -z $HTTPS_PROXY ]]; then
		https_proxy=$http_proxy
		HTTPS_PROXY=$HTTP_PROXY
	elif [[ -z $https_proxy ]]; then
		https_proxy=$HTTPS_PROXY
	elif [[ -z $HTTP_RPOXY ]]; then
		HTTPS_PROXY=$https_proxy
	fi
	# ftp
	if [[ -z $ftp_proxy && -z $FTP_PROXY ]]; then
		ftp_proxy=$http_proxy
		FTP_PROXY=$HTTP_PROXY
	elif [[ -z $ftp_proxy ]]; then
		ftp_proxy=$FTP_PROXY
	elif [[ -z $HTTP_RPOXY ]]; then
		FTP_PROXY=$ftp_proxy
	fi
	# rsync
	if [[ -z $rsync_proxy && -z $RSYNC_PROXY ]]; then
		rsync_proxy=$http_proxy
		RSYNC_PROXY=$HTTP_PROXY
	elif [[ -z $rsync_proxy ]]; then
		rsync_proxy=$RSYNC_PROXY
	elif [[ -z $HTTP_RPOXY ]]; then
		RSYNC_PROXY=$rsync_proxy
	fi
	# exceptions
	if [[ -z $no_proxy && -z $NO_PROXY ]]; then
		no_proxy="localhost,127.0.0.1"
		NO_PROXY=$no_proxy
	elif [[ -z $no_proxy ]]; then
		no_proxy=$NO_PROXY
	elif [[ -z $NO_PROXY ]]; then
		NO_PROXY=$no_proxy
	fi

	export http_proxy https_proxy ftp_proxy rsync_proxy no_proxy
	export HTTP_PROXY HTTPS_PROXY FTP_PROXY RSYNC_PROXY NO_PROXY
}

function proxy_off() {
	export -n http_proxy https_proxy ftp_proxy rsync_proxy no_proxy
	export -n HTTP_PROXY HTTPS_PROXY FTP_PROXY RSYNC_PROXY NO_PROXY
}
