# GetCurrentPraat_Linux.sh
# Looks up the current Linux version of Praat
# at Paul Boersma's server and unpacks the
# executable in the current directory.

# fanagled 8/2013 by dan brenner
# v1.2 3/2019 db
# still needs proper error handling

# This software is provided with only the guarantee
# that I've tried my best to create good code for
# the purpose. Please send me comments, bug reports,
# feature requests, suggestions.

# This software is provided under GNU General Public License:
#	https://www.gnu.org/licenses/gpl.html
# which means anyone is free to mess with this however
# they please, for any purpose, be it personal, commercial,
# poetic, arboreal, or whathaveyou.
# All derivative software must also bear this licensing.
#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#

# Get the local version of Praat
PRAAT_VERSION=`./praat --version`
PRAAT_VERSION=`perl -e '$ARGV[0] =~ m/(\d+)\.(\d+)\.(\d+)/; print "$1$2$3"' "$PRAAT_VERSION"`

# Grab the download page
wget http://www.fon.hum.uva.nl/praat/download_linux.html

# Parse out the current Praat version
PRAAT_LINE=`grep -P -m 1 -o '64-bit edition: <a href=praat\d+_linux64.tar.gz>' download_linux.html`
CURRENT_PRAAT_VERSION=`perl -e '$ARGV[0] =~ s/^64-bit edition: <a href=praat(\d+)_linux64\.tar\.gz>$/$1/; $ARGV[0] =~ s///; print $ARGV[0]' "$PRAAT_LINE"`
rm download_linux.html

# If the available version is the same, bail.
if [[ $CURRENT_PRAAT_VERSION == $PRAAT_VERSION ]]; then
	echo "Your installed version is already current: $PRAAT_VERSION"

# Otherwise, grab the Praat tarball
else
	wget http://www.fon.hum.uva.nl/praat/praat"$CURRENT_PRAAT_VERSION"_linux64.tar.gz
	# Untar
	tar xvfz praat"$CURRENT_PRAAT_VERSION"_linux64.tar.gz
	echo "Upgraded Praat $PRAAT_VERSION to $CURRENT_PRAAT_VERSION . Enjoy!"

	# Clean up
	rm praat"$CURRENT_PRAAT_VERSION"_linux64.tar.gz
fi
