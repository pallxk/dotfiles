# Add /usr/local/go/bin to PATH
if [ -d /usr/local/go/bin ]; then
	PATH=$PATH:/usr/local/go/bin
fi

# Add $GOPATH/bin to PATH
if [ -d ~/go/bin ]; then
	PATH=~/go/bin:$PATH
fi
