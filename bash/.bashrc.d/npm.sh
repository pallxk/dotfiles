# Enable tab completion for npm

# npm completion not supported on windows
[[ $(uname -s) = CYGWIN* ]] && return

# Check npm package is installed
command -v npm > /dev/null || return

. <(npm completion)
