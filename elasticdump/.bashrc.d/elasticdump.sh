elasticdump() {
  default_args="--limit=10000"
  for arg in "$@"; do
    if [[ $arg == --limit* ]]; then
      default_args=""
      break
    fi
  done
  command elasticdump $default_args "$@"
}
