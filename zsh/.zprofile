# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Homebrew QT5
if [ -d "/opt/homebrew/opt/qt@5/bin" ]; then
	PATH="/opt/homebrew/opt/qt@5/bin:$PATH"
fi

# Volta
if [ -d ~/.volta ]; then
	export VOLTA_HOME=~/.volta
	PATH=$VOLTA_HOME/bin:$PATH
fi
