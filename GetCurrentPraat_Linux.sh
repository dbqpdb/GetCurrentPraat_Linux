# GetCurrentPraat_Linux.sh
# Looks up the current Linux version of Praat
# at Paul Boersma's server and unpacks the
# executable in the current directory.

# fanagled 8/2013 by dan brenner
# v1.1 10/2013 db
# still needs proper error handling
#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#

wget http://www.fon.hum.uva.nl/praat/download_linux.html
PRAAT_LINE=`grep -P -m 1 -o '64-bit edition: <a href=praat\d+_linux64.tar.gz>' download_linux.html`
PRAAT_VERSION=`perl -e '$ARGV[0] =~ s/^64-bit edition: <a href=//; $ARGV[0] =~ s/_linux64\.tar\.gz>$//; print $ARGV[0]' "$PRAAT_LINE"`
wget http://www.fon.hum.uva.nl/praat/"$PRAAT_VERSION"_linux64.tar.gz
tar xvfz "$PRAAT_VERSION"_linux64.tar.gz
rm download_linux.html
rm "$PRAAT_VERSION"_linux64.tar.gz
