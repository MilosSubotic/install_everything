#!/bin/bash
##############################################################################

sudo apt -y install avahi-daemon
sudo service avahi-daemon restart

sudo apt -y install openssh-server 

sudo apt -y install nfs-client nfs-server
sudo -E tee -a /etc/exports << EOF
$HOME/Public    *(rw,sync,no_subtree_check)
EOF
sudo service nfs-server restart

##############################################################################


if [ `uname -m` == "aarch64" ]
then
    
    wget https://download.anydesk.com/rpi/anydesk_7.0.0-1_arm64.deb
    sudo dpkg -i anydesk*.deb

    # Run on start
    sudo sed -i '/After=systemd-user-sessions.service/a After=syslog.target network-online.target' /etc/systemd/system/anydesk.service

elif [ `uname -m` == "x86_64" ]
then
    
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

else
    echo 'Not supported arch!'
    exit 1
fi

# Xorg on login screen.
sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm3/custom.conf


##############################################################################

#sudo dpkg -i teamviewer_*_amd64.deb
#sudo apt -y install --fix-broken

##############################################################################
