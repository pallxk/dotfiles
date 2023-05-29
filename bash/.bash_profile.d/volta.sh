if [ -d ~/.volta ]; then
    export VOLTA_HOME=~/.volta
    PATH=$VOLTA_HOME/bin:$PATH
fi
