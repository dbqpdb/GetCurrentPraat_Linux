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

# Get the local version of Praat if it exists.
if [[ -f ./praat ]]; then
	PRAAT_VERSION=$(./praat --version)
	# "Praat 6.0.54 (June 6 2019)"
	PRAAT_VERSION=${PRAAT_VERSION// (*/} # drop the date element
	PRAAT_VERSION=${PRAAT_VERSION//[!0-9]/} # grab only the version digits
else
	PRAAT_VERSION="none"
fi


# Grab the download page
wget -q -o /dev/null https://www.fon.hum.uva.nl/praat/download_linux.html
if [[ $? -ne 0 ]]; then
	echo "Couldn't access the download page. Internet connection issue?"
	exit 0
fi

# Parse out the current Praat version
# The relevant line looks like:
# <a href="https://github.com/praat/praat/releases/download/v6.4.48/praat6448_linux-intel64.tar.gz">praat6448_linux-intel64.tar.gz</a>
# <a href=praat6134_linux64static.tar.gz>praat6134_linux64static.tar.gz</a>
PRAAT_LINE=$(grep -P -m 1 -o '<a href="https://github.com/praat/praat/releases/download/v\d+.\d+.\d+/praat\d+_linux-intel64.tar.gz">' download_linux.html)
rm download_linux.html
FRONT=${PRAAT_LINE%\/praat*}  # remove "/praatBLAH_linux..." from end.
VNUM=${FRONT##*v}
CURRENT_PRAAT_VERSION=${VNUM//./}  # remove dots

unset PRAAT_LINE FRONT

# rm download_linux.html

echo -e "PRAAT_VERSION -> ${PRAAT_VERSION}\nCURRENT_PRAAT_VERSION -> ${CURRENT_PRAAT_VERSION}\n"

# If the available version is the same, bail.
if [[ $CURRENT_PRAAT_VERSION == $PRAAT_VERSION ]]; then
	echo "Your installed version is current: $PRAAT_VERSION"
else
	# Otherwise, grab the Praat tarball
	TARBALL="praat${CURRENT_PRAAT_VERSION}_linux-intel64.tar.gz"
	wget https://github.com/praat/praat/releases/download/v${VNUM}/$TARBALL

	# Untar
	tar xvfz $TARBALL
	echo "Upgraded Praat $PRAAT_VERSION to $CURRENT_PRAAT_VERSION . Enjoy!"

	# Clean up
	rm $TARBALL
	unset PRAAT_VERSION CURRENT_PRAAT_VERSION TARBALL
fi
