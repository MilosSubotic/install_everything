#!/bin/bash
###############################################################################

mkdir tmp/
pushd tmp/

###############################################################################
# Discord.

V=0.0.54
wget https://dl.discordapp.net/apps/linux/$V/discord-$V.deb
sudo dpkg -i discord-$V.deb
sudo apt -y --fix-broken install
if [[ "$http_proxy" != "" ]];
then
	ADD="--proxy-server=\"${http_proxy#*//}\""
	WHAT="Exec=/usr/share/discord/Discord"
	WHAT="${WHAT////\\/}"
	F="/usr/share/discord/discord.desktop"
	sudo sed -i "s/^$WHAT/$WHAT $ADD/g" "$F"
	sudo xdg-desktop-menu install --manual "$F"
	sudo xdg-desktop-icon install --manual "$F"
fi

###############################################################################
# Comms.

# Viber.
wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
sudo apt -y purge viber
sudo dpkg -i viber.deb
rm viber.deb

# Telegram.
sudo apt -y install telegram-desktop
sudo apt -y --fix-broken install


# WhatsApp.
sudo apt install snapd
sudo snap install whatsapp-for-linux

###############################################################################
popd
rm -rf tmp/

###############################################################################

echo "End"

###############################################################################