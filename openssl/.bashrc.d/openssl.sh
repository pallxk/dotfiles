# https://docs.openssl.org/1.1.1/man1/s_client/

showcerts() {
  openssl s_client -showcerts "$@" <<< Q
}

showcertspem() {
  openssl s_client -showcerts "$@" <<< Q 2>/dev/null \
    | openssl x509
}

showcertstext() {
  openssl s_client -showcerts "$@" <<< Q 2>/dev/null \
    | openssl x509 -text -noout
}
