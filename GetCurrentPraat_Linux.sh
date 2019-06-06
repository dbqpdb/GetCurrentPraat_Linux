# GetCurrentPraat_Linux.sh
# Looks up the current Linux version of Praat
# at Paul Boersma's server and unpacks the
# executable in the current directory.

# fanagled 8/2013 by dan brenner
# v1.2 3/2019 db

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
PRAAT_VERSION=${PRAAT_VERSION// (*/} # drop the date element
PRAAT_VERSION=${PRAAT_VERSION//[!0-9]/} # grab only the version digits

# Grab the download page
wget -q -o /dev/null http://www.fon.hum.uva.nl/praat/download_linux.html
if [[ $? -ne 0 ]]; then
	echo "Couldn't access the download page. Internet connection issue?"
	exit 0
fi

# Parse out the current Praat version
PRAAT_LINE=`grep -P -m 1 -o '64-bit edition: <a href=praat\d+_linux64.tar.gz>' download_linux.html`
# the line contains something of the form:
# "64-bit edition: <a href=praat6054_linux64.tar.gz>"
PRAAT_LINE=${PRAAT_LINE//_*/} # zap "_linux64..." blah blah
CURRENT_PRAAT_VERSION=${PRAAT_LINE//*praat/} # squash blah blah "...praat"
unset PRAAT_LINE

rm download_linux.html

# If the available version is the same, bail.
if [[ $CURRENT_PRAAT_VERSION == $PRAAT_VERSION ]]; then
	echo "Your installed version is current: $PRAAT_VERSION"
else
	# Otherwise, grab the Praat tarball
	TARBALL="praat${CURRENT_PRAAT_VERSION}_linux64.tar.gz"
	wget http://www.fon.hum.uva.nl/praat/$TARBALL

	# Untar
	tar xvfz $TARBALL
	echo "Upgraded Praat $PRAAT_VERSION to $CURRENT_PRAAT_VERSION . Enjoy!"

	# Clean up
	rm $TARBALL
	unset PRAAT_VERSION CURRENT_PRAAT_VERSION TARBALL
fi
