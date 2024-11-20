dnetshoot() {
  docker run --rm -it -v /tmp:/tmp "$@" nicolaka/netshoot
}
