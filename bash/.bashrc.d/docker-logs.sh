sdlogs() {
  hosts=()
  while [ "$1" ]; do
    if [ "$1" == -- ]; then
      shift
      break
    else
      hosts+=("$1")
      shift
    fi
  done

  for host in "${hosts[@]}"; do
    command ssh "$host" docker logs "$@" &
  done

  wait
}
