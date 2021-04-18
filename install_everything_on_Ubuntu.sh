#!/bin/bash
###############################################################################
# Just to obtain sudo rights.

sudo ls

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

# Hack because newer Ubuntu does not have python2.
if (( $MAJOR >= 20 ))
then
	#ln -s `which python3` ~/.local/bin/python
	sudo apt -y install python-is-python3
fi

mkdir -p ~/.local/bin/
mkdir -p ~/.local/opt/

###############################################################################
# Git.

sudo apt -y install git
./setup_git_stuff.sh

###############################################################################
# Worker.

if (( $MAJOR >= 20 ))
then
	pushd worker_install/
	./install_worker.sh
	popd
else
	pushd worker_install/
	./build_and_install_worker.sh
	popd
fi

###############################################################################
# Atom.

#wget https://atom.io/download/deb -O atom-amd64.deb
#sudo dpkg -i atom-amd64.deb

#curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
#sudo sh -c 'echo "deb [arch=amd64]
#sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
#sudo apt update
#sudo apt install atom

wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt update
sudo apt -y install atom

# Install settings.
cp -rv ../.atom/ ~/

# Install packages.
apm install language-matlab linter-matlab
apm install language-markdown
apm install language-vhdl language-verilog language-tcl

###############################################################################
# Julia.

wget https://julialang-s3.julialang.org/bin/linux/x86/1.6/julia-1.6.0-linux-i686.tar.gz

mkdir -p ~/.local/opt/julia

tar xfv julia-1.6.0-linux-i686.tar.gz -C ~/.local/opt/julia

pushd ~/.local/bin/
ln -sf ../opt/julia/julia-1.6.0/bin/julia julia160
ln -sf julia160 julia
popd

#F=~/.juliarc.jl
#mkdir -p $(dirname $F)
#if test -f $F
#then
#	cp $F $F.backup-$(date +%F-%T | sed 's/:/-/g')
#fi
#cat > $F << EOF
#push!(LOAD_PATH, ".")
#EOF

F=~/.julia/config/startup.jl
mkdir -p $(dirname $F)
if test -f $F
then
	cp $F $F.backup-$(date +%F-%T | sed 's/:/-/g')
fi
cat > $F << EOF
push!(LOAD_PATH, ".")
EOF

apm install language-julia

###############################################################################
# Beyond Compare.

wget https://www.scootersoftware.com/bcompare-4.3.7.25118_amd64.deb
sudo dpkg -i bcompare-*.deb

###############################################################################
# Discord.

V=0.0.14
wget https://dl.discordapp.net/apps/linux/$V/discord-$V.deb
sudo dpkg -i discord-0.0.14.deb
sudo apt -y --fix-broken install
if [[ "$http_proxy" != "" ]];
then
	ADD='--proxy-server="proxy.uns.ac.rs:8080"'
	WHAT="Exec=/usr/share/discord/Discord"
	WHAT="${WHAT////\\/}"
	F="/usr/share/discord/discord.desktop"
	sudo sed -i "s/^$WHAT/$WHAT $ADD/g" "$F"
	sudo xdg-desktop-menu install --manual "$F"
	sudo xdg-desktop-icon install --manual "$F"
fi

###############################################################################
# Google Chrome.

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

###############################################################################
# Install utils.

cp utils/* ~/.local/bin/

###############################################################################

./install_waf_bash_completition.sh
./install_latex.sh
./install_kicad.sh
#./install_arduino.sh

###############################################################################

popd
rm -rf tmp/

###############################################################################

echo "End"

###############################################################################
