# Alias definitions.

# set up color for ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# enable color support if has dircolors or on mac
if [ -x /usr/bin/dircolors ] || [ "$(uname)" = Darwin ]; then
    # enable color support of ls and also add handy aliases

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    # Output raw ANSI color escape sequences
    alias less='less -R'

    # Colorize diff output
    command -v colordiff > /dev/null && alias diff='colordiff'
fi


# some more ls aliases
# List entries by column with indicator appended
#alias l='ls -CF'
# List in a long format
alias ll='ls -l'
# List only hidden entries
alias l.='ls -d .*'
alias ll.='ls -dl .*'
# List all entries (not including . & ..)
alias la='ls -A'
alias lla='ls -Al'
# List only directories themselves
alias ld='ls -d */'
alias lld='ls -dl */'


# Be safe
if [ "$(uname)" != Darwin ] || [ "$(which chmod)" != /bin/chmod ]; then
    # --preserve-root works with GNU/Linux only
    alias chmod='chmod --preserve-root'
    alias chown='chown --preserve-root'
    alias chgrp='chgrp --preserve-root'
fi

# `-i' option of `cp' cannot be overridden by `-f', thus commented out
#alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'
if [ "$(uname)" != Darwin ]; then
    # `-I' option of `rm' cannot be overriden by `-f' on macOS
    alias rm='rm -I'
fi


# More warning messages for compilers
alias gcc='gcc -Wall -Wextra -Wpedantic'
alias g++='g++ -Wall -Wextra -Wpedantic'


# Single letter alias
alias c=curl
alias g=git
alias h=http
alias s=https


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Show top 10 history command on screen
history-top () {
    # Reset the history formatting locally, so that history parsing can work
    local HISTTIMEFORMAT
    history | awk '{a[$2]++;n++}END{for(i in a){print a[i] " " a[i]/n*100 "% " i}}' | sort -rn | head
}
