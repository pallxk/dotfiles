#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Apply a fancy color scheme
[[ -f colorschemes/default.sh ]] && . colorschemes/default.sh

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Set up default editor
hash vim 2> /dev/null && VISUAL=vim || VISUAL=vi
export VISUAL
export EDITOR="$VISUAL"
