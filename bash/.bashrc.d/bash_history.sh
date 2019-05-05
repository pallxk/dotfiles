# A Better Bash History
# =====================

# Perform history expansion on the current line and insert a space
bind 'Space: magic-space'
# Append to the history file, instead of overwriting it
shopt -s histappend
# Ignore lines matching the previous entry (ignoredups)
# Ignore lines which begin with a space character (ignorespace)
HISTCONTROL=ignoreboth
# The maximum number of lines contained in the history file
HISTFILESIZE=100000
# The number of commands to remeber in the command history
HISTSIZE=10000
# Write time stamps to the history file, but not displaying them
HISTTIMEFORMAT=
# Write time stamps to the history file, and format them when displaying
HISTTIMEFORMAT='%m-%d %H:%M '
