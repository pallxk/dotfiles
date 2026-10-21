if [ -f "$HOMEBREW_PREFIX/opt/helm@3/bin/helm" ]; then
	alias helm3="$HOMEBREW_PREFIX/opt/helm@3/bin/helm"
fi

if [ -f "$HOMEBREW_PREFIX/opt/helm@4/bin/helm" ]; then
	alias helm4="$HOMEBREW_PREFIX/opt/helm@4/bin/helm"
fi
