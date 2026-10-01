# https://developer.android.com/tools/variables#envar
if [ -z "$ANDROID_HOME" ] && [ -d "$HOME/Library/Android/sdk" ]; then
	export ANDROID_HOME=$HOME/Library/Android/sdk
	export ANDROID_SDK_ROOT=$ANDROID_HOME
fi
