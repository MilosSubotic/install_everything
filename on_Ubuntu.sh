#!/bin/bash
###############################################################################

# Warm up sudo.
sudo -v

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
# Global stuff.

# For larger fonts.
gsettings set org.gnome.desktop.interface text-scaling-factor 1.5
# For changing language.
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Alt>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Alt>Left']"

sudo apt -y update
sudo apt -y upgrade

sudo apt -y install aptitude

# 32b app support.
sudo dpkg --add-architecture i386
sudo apt -y install libc6:i386 libncurses5:i386 libstdc++6:i386

sudo apt -y install git build-essential

mkdir -p ~/.local/bin/
mkdir -p ~/.local/opt/

###############################################################################
# Julia.

./install_julia.sh

###############################################################################
# Worker.

pushd worker/
if (( $MAJOR >= 20 ))
then
	./install_worker.sh
else
	./build_and_install_worker.sh
fi
popd

###############################################################################
# VSC

wget --content-disposition https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i code*.deb
rm code*.deb

###############################################################################
# Google Chrome.

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

###############################################################################
# Beyond Compare.

wget https://www.scootersoftware.com/DEB-GPG-KEY-scootersoftware.asc
sudo mv DEB-GPG-KEY-scootersoftware.asc /etc/apt/trusted.gpg.d/
wget https://www.scootersoftware.com/scootersoftware.list
sudo mv scootersoftware.list /etc/apt/sources.list.d/
sudo apt update
sudo apt -y install bcompare

###############################################################################
# Programmers stuff.

sudo apt -y install g++ cmake pkg-config
sudo apt -y install tmux xsel
sudo apt -y install libsfml-dev

###############################################################################

./install_git_stuff.sh

./install_waf_stuff.sh

./install_arduino.sh

pushd kicad/
./install_kicad.sh
popd

./install_qt.sh
#./install_ros.sh

./install_latex.sh

#FIXME kicad and freecad libocct are in fight.
#./install_freecad.sh

pushd Quartus/
./install.sh
popd

###############################################################################

echo "End"

###############################################################################
