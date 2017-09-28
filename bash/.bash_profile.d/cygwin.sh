# Cygwin-specific scripts

[[ $(uname -s) = CYGWIN* ]] || return

# CHERE_INVOKING is checked in /etc/profile,
# which prevents auto cd to home directory when starting a new login shell.
export CHERE_INVOKING=1

# Fix "Can't locate Git.pm in @INC"
export PERL5LIB=/usr/lib/perl5/vendor_perl/5.22
