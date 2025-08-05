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
sudo apt -y install flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak -y install flathub com.viber.Viber
mkdir -p ~/.local/bin
cat >> ~/.local/bin/viber << EOF
#!/bin/bash
flatpak run com.viber.Viber
EOF
chmod a+x ~/.local/bin/viber

# Telegram.
#sudo apt -y install telegram-desktop
#sudo apt -y install --fix-broken
sudo snap install telegram-desktop

# WhatsApp.
sudo apt -y install snapd
#TODO Figure it out sudo -E snap install whatsapp-for-linux

###############################################################################
popd
rm -rf tmp/

###############################################################################

echo "End"

###############################################################################