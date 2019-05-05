# Cygwin-specific scripts

[[ $(uname -s) = CYGWIN* ]] || return

# CHERE_INVOKING is checked in /etc/profile,
# which prevents auto cd to home directory when starting a new login shell.
export CHERE_INVOKING=1
