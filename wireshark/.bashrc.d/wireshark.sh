dshark() {
  temp_fifo=$(mktemp -u)
  mkfifo -m 600 "$temp_fifo"
  wireshark -k -i "$temp_fifo" &
  docker run --rm -i --network container:"$1" "${2:-nicolaka/netshoot}" dumpcap -w - "${@:3}" >"$temp_fifo"
  rm -f "$temp_fifo"
}

sdshark() {
  temp_fifo=$(mktemp -u)
  mkfifo -m 600 "$temp_fifo"
  wireshark -k -i "$temp_fifo" &
  command ssh "$1" docker run --rm -i --network container:"$2" "${3:-nicolaka/netshoot}" dumpcap -w - "${@:4}" >"$temp_fifo"
  rm -f "$temp_fifo"
}
