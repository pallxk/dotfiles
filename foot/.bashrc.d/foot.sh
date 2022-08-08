# TERM=foot doesn't work well for ssh
if [ "$TERM" = foot ]; then
  TERM=xterm-256color
fi
