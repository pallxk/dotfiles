[ -x /opt/homebrew/bin/brew ] || return

eval "$(/opt/homebrew/bin/brew shellenv)"

PATH=/opt/homebrew/opt/grep/libexec/gnubin:$PATH
