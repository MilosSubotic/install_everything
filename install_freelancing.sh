#!/bin/bash

#TODO 
#wget https://upwork-usw2-desktopapp.upwork.com/binaries/v5_8_0_35_be1a1520901c4eef/upwork_5.8.0.35_amd64.deb

# Download from https://www.upwork.com/ab/downloads

sudo dpkg -i upwork_5.8.0.35_amd64.deb
sudo apt -y --fix-broken install
