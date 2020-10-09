# Enable tab completion for npm

# npm completion not supported on windows
[[ $(uname -s) = CYGWIN* ]] && return

# Check npm package is installed
npm_path=$(command -v npm)

# No completion if we're inside WSL while npm is in Windows
if [ -z "$npm_path" ] || [[ "$npm_path" = /mnt/* ]]; then
	return
fi

. <(npm completion)
