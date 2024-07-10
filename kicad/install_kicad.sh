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

D="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

###############################################################################
# KiCAD.

if (( $MAJOR < 16 ))
then
	sudo -E add-apt-repository --yes ppa:js-reynaud/kicad-5
elif (( $MAJOR < 20 ))
then
	#sudo -E add-apt-repository --yes ppa:kicad/kicad-5.1-releases
	sudo -E add-apt-repository --yes ppa:kicad/kicad-6.0-releases
	# Copy config.
	mkdir ~/.config/kicad/
	cp -rfv $D/.config/kicad/6.0 ~/.config/kicad/
else
	sudo -E add-apt-repository --yes ppa:kicad/kicad-8.0-releases
	# Copy config.
	cp -rfv $D/.config/kicad/8.0 ~/.config/kicad/
fi
sudo apt update
sudo apt install -y kicad

###############################################################################
# Third party libs.

if false
then
	USER_LIBS_DIR=$HOME/ELEKTRONIKA/A_PROGRAM_CODE/Electronic/KiCAD/Libs
	
	mkdir -p $USER_LIBS_DIR
	pushd $USER_LIBS_DIR
	git clone https://github.com/digikey/digikey-kicad-library
	popd
	
	DIGIKEY_SYMBOL_DIR=$USER_LIBS_DIR/digikey-kicad-library/digikey-symbols/
	KICAD_CONFIG_FILE=$HOME/.config/kicad/sym-lib-table
	
	sed -i '$ d' $KICAD_CONFIG_FILE
	for f in $DIGIKEY_SYMBOL_DIR/*.lib
	do
		n=$(basename -s .lib $f)
		echo "  (lib (name $n)(type Legacy)(uri $f)(options \"\")(descr \"\"))" >> $KICAD_CONFIG_FILE
	done
	echo ')' >> $KICAD_CONFIG_FILE
fi

###############################################################################
