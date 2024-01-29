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
# Doing all package downloading and unpacking in tmp dir.

mkdir tmp/
pushd tmp/

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

sudo usermod -a -G dialout $USER

###############################################################################

./install_waf_stuff.sh

###############################################################################
# Git.

./install_git_stuff.sh

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
## Atom.
#
#wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
#sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
#sudo apt update
#sudo apt -y install atom
#
## Install settings.
#cp -rv .atom/ ~/
#
## Install packages.
#apm install language-matlab linter-matlab
#apm install language-markdown
#apm install language-vhdl language-verilog language-tcl
#
###############################################################################
# VSC

wget --content-disposition https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i code*.deb
rm code*.deb

###############################################################################
# Julia.

./install_julia.sh

#apm install language-julia

###############################################################################
# Beyond Compare.

wget https://www.scootersoftware.com/bcompare-4.4.5.27371_amd64.deb
sudo dpkg -i bcompare-*.deb

###############################################################################
# Google Chrome.

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

###############################################################################
# Install utils.

cp utils/* ~/.local/bin/

###############################################################################

sudo apt -y install tmux xsel
sudo apt -y install libsfml-dev

###############################################################################

./install_latex.sh
./install_arduino.sh

pushd kicad
./install_kicad.sh
popd
install_freecad.sh

###############################################################################

popd
rm -rf tmp/

###############################################################################

echo "End"

###############################################################################
