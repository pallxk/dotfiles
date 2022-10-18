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


# Add Yarn global to PATH
[[ -d ~/.yarn/bin ]] && pathmunge ~/.yarn/bin

# Add RVM to PATH for scripting
[[ -d ~/.rvm/bin ]] && pathmunge ~/.rvm/bin

# Add kubernetes plugins to PATH
[[ -d ~/.krew/bin ]] && pathmunge ~/.krew/bin

# include ruby bin directories in PATH
# (Prefer using rvm)
#for dir in ~/.local/share/gem/ruby/*/bin; do
#	test -d "$dir" && pathmunge "$dir"
#done

# Add dotnet tools
[[ -d ~/.dotnet/tools ]] && pathmunge ~/.dotnet/tools

# Add ~/.local/bin
[[ -d ~/.local/bin ]] && pathmunge ~/.local/bin

# set PATH so it includes user's private bin if it exists
[[ -d ~/bin ]] && pathmunge ~/bin
[[ -d ~/bin/after ]] && pathmunge ~/bin/after after

# Include Applications bin directories in PATH
for dir in ~/Applications/*/bin; do
	test -d "$dir" && pathmunge "$dir" after
done
for dir in ~/nativefier-apps/*; do
	test -d "$dir" && pathmunge "$dir" after
done

# include .bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc

unset dir
unset -f pathmunge
