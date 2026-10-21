if [ -x /opt/homebrew/bin/brew ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
	PATH=/opt/homebrew/opt/grep/libexec/gnubin:$PATH
elif [ -x /opt/brew/bin/brew ]; then
	eval "$(/opt/brew/bin/brew shellenv)"
	PATH=/opt/brew/opt/grep/libexec/gnubin:$PATH
fi
