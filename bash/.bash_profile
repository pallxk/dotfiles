#
# ~/.bash_profile
#

# set PATH so it includes user's private bin if it exists
[[ -d ~/bin ]] && PATH=~/bin:$PATH
[[ -d ~/bin/after ]] && PATH=$PATH:~/bin/after

# include .bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc
