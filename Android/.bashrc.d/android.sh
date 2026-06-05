if [ -z "$ANDROID_HOME" ] && [ -d "$HOME/Library/Android/sdk" ]; then
	export ANDROID_HOME=$HOME/Library/Android/sdk
fi
