# the sequence 'OSC 1337 ; SetMark ST' originally created by iTerm2
setmark() {
  echo -en '\x1b]1337;SetMark\x07'
  echo "$@"
}
