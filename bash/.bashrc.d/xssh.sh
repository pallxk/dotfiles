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
    command ssh "$host" "$@" | ts "$host:" &
  done

  # Be quiet on job exit
  wait 2> /dev/null
}
