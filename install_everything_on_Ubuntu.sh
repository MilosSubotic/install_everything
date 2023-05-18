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

mkdir -p ~/.local/bin/
mkdir -p ~/.local/opt/

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
cp -rv .atom/ ~/

# Install packages.
apm install language-matlab linter-matlab
apm install language-markdown
apm install language-vhdl language-verilog language-tcl

###############################################################################
# Julia.

V1=1
V2=7
V3=2
A=i686
F=julia-$V1.$V2.$V3-linux-$A.tar.gz
wget https://julialang-s3.julialang.org/bin/linux/x86/$V1.$V2/$F

mkdir -p ~/.local/opt/julia/$A

tar xfv $F -C ~/.local/opt/julia/$A

mkdir -p ~/.local/bin/
pushd ~/.local/bin/
ln -sf ../opt/julia/$A/julia-$V1.$V2.$V3/bin/julia julia$V1$V2$V3
ln -sf julia$V1$V2$V3 julia
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

wget https://www.scootersoftware.com/bcompare-4.4.5.27371_amd64.deb
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

# Viber.
wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
sudo apt -y purge viber
sudo dpkg -i viber.deb
rm viber.deb
setxkbmap -query
setxkbmap -layout 'us,rs,gr,us' -variant ' ,latin, , '
setxkbmap -query


###############################################################################
# Google Chrome.

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

###############################################################################
# Install utils.

cp utils/* ~/.local/bin/

###############################################################################

./install_latex.sh
./install_arduino.sh

###############################################################################

pushd kicad
./install_kicad.sh
popd

###############################################################################

popd
rm -rf tmp/

###############################################################################

echo "End"

###############################################################################
