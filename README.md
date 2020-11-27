## What is GCPL?

GCPL is a *nix shell script that updates your Linux Praat version from the [UvA website](https://www.fon.hum.uva.nl/praat/download_linux.html). It is written with Linux in mind, but may be adapted for use on Mac's (easy) or Windows machines (somewhat harder).

## How to use the hack --- er, rather, the _script_.

`git clone https://github.com/dbqpdb/GetCurrentPraat_Linux.git`
`cd GetCurrentPraat_Linux`
`./GetCurrentPraat_Linux.sh`

This will place the current compiled Linux binaries in this directory. It's recommended to alias this location to `praat`. Rerunning the script periodically will check whether a newer version is available and will update it as needed.

Et Voilà!
