#
# ~/.bash_profile
#

# set PATH so it includes user's private bin if it exists
[[ -d ~/bin ]] && PATH=~/bin:$PATH

# include .bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc
