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
sudo apt -y install xdg-utils
mkdir -p ~/.local/bin
cat >> ~/.local/bin/viber << EOF
#!/bin/bash
flatpak run com.viber.Viber
EOF
chmod a+x ~/.local/bin/viber

# Telegram.
#sudo apt -y install telegram-desktop
#sudo apt -y install --fix-broken
sudo apt -y install snapd
sudo snap install telegram-desktop

# WhatsApp.
sudo apt -y install snapd
sudo -E snap install whatsdesk
# Use system proxy. Start on WiFi without proxy, then switch to LAN with proxy.

#TODO https://www.google.com/search?q=Franz+install+ubuntu&sca_esv=7b647de37a4058b4&cs=0&ei=TpaXaOeSBbCMxc8P8oS_gQM&ved=0ahUKEwjn8ePJsP6OAxUwRvEDHXLCLzAQ4dUDCBA&uact=5&oq=Franz+install+ubuntu&gs_lp=Egxnd3Mtd2l6LXNlcnAiFEZyYW56IGluc3RhbGwgdWJ1bnR1MgYQABgIGB4yBRAAGO8FMgUQABjvBUjvG1CaBFidGnABeAGQAQCYAa8BoAHSDaoBBDEuMTS4AQPIAQD4AQGYAgygAuMKwgIKEAAYsAMY1gQYR8ICDRAAGIAEGLADGEMYigXCAhMQLhiABBiwAxhDGMgDGIoF2AEBwgIFEC4YgATCAg0QLhiABBhDGNQCGIoFwgIKEC4YgAQYQxiKBcICBRAAGIAEwgIUEC4YgAQYlwUY3AQY3gQY3wTYAQLCAgcQABiABBgTwgIKEAAYExgWGAoYHsICCBAAGBMYFhgewgIIEAAYgAQYogTCAgkQABiABBgTGA3CAgoQABgTGAcYCBgewgIKEAAYExgFGA0YHsICCBAAGAcYCBgemAMAiAYBkAYMugYECAEYCLoGBggCEAEYFJIHBDEuMTGgB_N1sgcEMC4xMbgH1QrCBwcyLTcuNC4xyAdk&sclient=gws-wiz-serp
# WhatsApp + Slack + WeChat
wget --content-disposition https://github.com/meetfranz/franz/releases/download/v5.11.0/franz_5.11.0_amd64.deb
sudo dpkg -i franz*.deb
rm -rf franz*.deb
#https://www.youtube.com/watch?v=ru9cTFbqryk
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak run com.meetfranz.Franz

#FIXME does not work

###############################################################################
popd
rm -rf tmp/

###############################################################################

echo "End"

###############################################################################