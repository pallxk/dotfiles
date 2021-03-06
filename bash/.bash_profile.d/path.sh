# SYNOPSIS:
#   pathmunge [path_variable] path [after]
# EXAMPLES:
#   pathmunge ~/bin
#   pathmunge ~/bin/after after
#   pathmunge MANPATH ~/man
#   pathmunge INFOPATH ~/info after
pathmunge () {
    # The path variable (which is ended with PATH, case-sensitive) to be munged
    # (defaults to PATH)
    local pathvar
    if [[ $1 = *PATH ]]; then
        pathvar="$1"
        shift
    else
        pathvar=PATH
    fi

    # Munge the path variable
    case ":${!pathvar}:" in
        *:"$1":*)
            ;;
        *)
            if [ "$2" = "after" ] ; then
                # `eval` is required here, otherwise the assignment as a whole
                # is seen as a command.
                eval ${pathvar}='${!pathvar}:$1'
            else
                eval ${pathvar}='$1:${!pathvar}'
            fi
    esac
}


# include ruby bin directories in PATH
# (Prefer using rvm)
#for dir in ~/.gem/ruby/*/bin; do
#	test -d "$dir" && pathmunge "$dir"
#done
#unset dir

# Include Applications bin directories in PATH
for dir in ~/Applications/*/bin; do
	test -d "$dir" && pathmunge "$dir"
done
unset dir

# Add Homebrew
[[ -d /home/linuxbrew/.linuxbrew/bin ]] && pathmunge /home/linuxbrew/.linuxbrew/bin after

# Add dotnet tools
[[ -d ~/.dotnet/tools ]] && pathmunge ~/.dotnet/tools after

# Add Yarn global to PATH
[[ -d ~/.yarn/bin ]] && pathmunge ~/.yarn/bin after

# Add RVM to PATH for scripting
[[ -d ~/.rvm/bin ]] && pathmunge ~/.rvm/bin after

# Add ~/.local/bin
[[ -d ~/.local/bin ]] && pathmunge ~/.local/bin

# set PATH so it includes user's private bin if it exists
[[ -d ~/bin ]] && pathmunge ~/bin
[[ -d ~/bin/after ]] && pathmunge ~/bin/after after

# include .bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc

unset -f pathmunge
