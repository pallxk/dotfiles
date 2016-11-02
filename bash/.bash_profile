# ~/.bash_profile

# User wide environment and startup programs, for login setup
# Functions and aliases go in ~/.bashrc

pathmunge () {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
            if [ "$2" = "after" ] ; then
                PATH=$PATH:$1
            else
                PATH=$1:$PATH
            fi
    esac
}

# Set umask if not set
[ `umask` = 0000 ] && umask 022

# include ruby bin directories in PATH
for dir in ~/.gem/ruby/*/bin; do
	test -d "$dir" && pathmunge "$dir"
done
unset dir

# set PATH so it includes user's private bin if it exists
[[ -d ~/bin ]] && pathmunge ~/bin
[[ -d ~/bin/after ]] && pathmunge ~/bin/after after

# include .bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc

unset -f pathmunge
