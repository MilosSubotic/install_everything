#!/bin/bash
##############################################################################

# Add the AnyDesk GPG key
sudo apt update
sudo apt -y install ca-certificates curl apt-transport-https
sudo install -m 0755 -d /etc/apt/keyrings
sudo -E curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY -o /etc/apt/keyrings/keys.anydesk.com.asc
sudo chmod a+r /etc/apt/keyrings/keys.anydesk.com.asc

# Add the AnyDesk apt repository
echo "deb [signed-by=/etc/apt/keyrings/keys.anydesk.com.asc] https://deb.anydesk.com all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list > /dev/null

# Update apt caches and install the AnyDesk client
sudo apt update
sudo apt -y install anydesk

##############################################################################

sudo dpkg -i teamviewer_*_amd64.deb
sudo apt -y install --fix-broken

##############################################################################
