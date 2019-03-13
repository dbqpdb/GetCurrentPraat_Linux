# GetCurrentPraat_Linux.sh
# Looks up the current Linux version of Praat
# at Paul Boersma's server and unpacks the
# executable in the current directory.

# fanagled 8/2013 by dan brenner
# v1.1 10/2013 db
# still needs proper error handling
#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#

# Grab the download page
wget http://www.fon.hum.uva.nl/praat/download_linux.html

# Parse out the current Praat version
PRAAT_LINE=`grep -P -m 1 -o '64-bit edition: <a href=praat\d+_linux64.tar.gz>' download_linux.html`
CURRENT_PRAAT_VERSION=`perl -e '$ARGV[0] =~ s/^64-bit edition: <a href=//; $ARGV[0] =~ s/_linux64\.tar\.gz>$//; print $ARGV[0]' "$PRAAT_LINE"`
rm download_linux.html

# If the available version is the same, bail.
if [[ "$CURRENT_PRAAT_VERSION" == "PRAAT_VERSION" ]]; then
	echo "Your installed version is already current."

# Otherwise, grab the Praat tarball
else
	wget http://www.fon.hum.uva.nl/praat/"$CURRENT_PRAAT_VERSION"_linux64.tar.gz
	# Untar
	tar xvfz "$CURRENT_PRAAT_VERSION"_linux64.tar.gz
	echo "Upgraded Praat $PRAAT_VERSION to $CURRENT_PRAAT_VERSION . Enjoy!"
	PRAAT_VERSION="$CURRENT_PRAAT_VERSION"

	# Clean up
	rm "$CURRENT_PRAAT_VERSION"_linux64.tar.gz
fi
