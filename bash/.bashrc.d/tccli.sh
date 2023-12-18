# Enable tab completion for tccli

# Check tccli package is installed
command -v tccli_completer > /dev/null || return;

complete -C tccli_completer tccli

alias tc=tccli
complete -C tccli_completer tc
