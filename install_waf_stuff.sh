#!/bin/bash
###############################################################################
# Check is this Ubuntu.

DIST=`lsb_release --id | sed 's/^Distributor ID:[\t ]*\(.*\)$/\1/'`
if [[ "$DIST" != "Ubuntu" ]]
then
	echo "This install script is made for Ubuntu GNU/Linux distribution!"
	echo "You need to change it a little for your distribution!"
	exit 1
fi

R=`lsb_release --release`
MAJOR=`echo $R | sed -n 's/^Release:[\t ]*\([0-9]\+\)\.\([0-9]\+\)$/\1/p'`

###############################################################################

#TODO Check again on freshly Ubuntu 22
#if (( $MAJOR < 22 ))
#then
#	sudo apt -y install python-is-python3
#elif (( $MAJOR < 20 ))
#then
#	sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 3
#fi

if (( $MAJOR < 20 ))
then
	sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 3
else
	sudo apt -y install python-is-python3
fi

./install_waf_bash_completition.sh

###############################################################################
