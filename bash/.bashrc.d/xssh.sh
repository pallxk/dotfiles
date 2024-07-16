xssh() {
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

  # If no -- is specified, assume the last arg of this function is for ssh
  if [ $# -eq 0 ]; then
    set -- "${hosts[-1]}"
    hosts=(${hosts[@]:0:${#hosts[@]}-1})
  fi

  for host in "${hosts[@]}"; do
    echo >&2 -n "$host: "
    { command ssh "$host" "$@" | ts "$host:" ; echo ; } &
  done

  # Be quiet on job exit
  wait 2> /dev/null
}
