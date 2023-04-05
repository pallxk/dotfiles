# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Window Manager
# https://wiki.archlinux.org/title/Sway#Manually
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  # Configure IM
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS="@im=fcitx"

  echo 'Launching sway...'
  # https://github.com/swaywm/sway/issues/5834#issuecomment-736368825
  WLR_NO_HARDWARE_CURSORS=1 exec sway > ~/.config/sway/stdout 2> ~/.config/sway/stderr
fi

# Autorun
## Autorun ssh-agent
if [[ -z $SSH_AUTH_SOCK ]] && hash ssh-agent 2> /dev/null; then
	# A login shell has its first character of argument zero as a -,
	# remove that when executed as a subprocess of the ssh-agent.
	exec ssh-agent "${0#-}" "$@"
fi

# Load rc files from ".bashrc.d" and ".bashrc.d/after"
for rcfile in ~/.bashrc.d/{,after}/*.{sh,bash}; do
	test -r "$rcfile" && . "$rcfile"
done
unset rcfile
disown -ar


# Disallow existing regular files to be overwritten by redirection of output
set -o noclobber

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar


# Set up default editor
hash vim 2> /dev/null && VISUAL=vim || VISUAL=vi
export VISUAL
export EDITOR="$VISUAL"

# Set up default browser if not already set
if [ -z "$BROWSER" ]; then
  hash microsoft-edge-stable 2> /dev/null && BROWSER=microsoft-edge-stable
  export BROWSER
fi
