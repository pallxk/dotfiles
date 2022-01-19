# source with allexport option set
.a() {
  set -a
  . "$@"
  set +a
}
