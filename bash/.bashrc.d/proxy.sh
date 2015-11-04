function proxy_on() {
export http_proxy=http://127.0.0.1:1080/
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
export rsync_proxy=$http_proxy
export no_proxy="localhost,127.0.0.1"

export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$https_proxy
export FTP_PROXY=$ftp_proxy
export RSYNC_PROXY=$rsync_proxy
export NO_PROXY=$no_proxy
}

function proxy_off() {
unset http_proxy
unset https_proxy
unset ftp_proxy
unset rsync_proxy
unset no_proxy

unset HTTP_PROXY
unset HTTPS_PROXY
unset FTP_PROXY
unset RSYNC_PROXY
unset NO_PROXY
}
