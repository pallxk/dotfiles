# Alias definitions.

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
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
alias l='ls -CF'
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
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias chgrp='chgrp --preserve-root'

# `-i' option of `cp' cannot be overridden by `-f', thus commented out
#alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias ln='ln -i'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Show top 10 history command on screen
history-top () {
    # Reset the history formatting locally, so that history parsing can work
    local HISTTIMEFORMAT
    history | awk '{a[$2]++;n++}END{for(i in a){print a[i] " " a[i]/n*100 "% " i}}' | sort -rn | head
}
