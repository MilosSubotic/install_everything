#!/bin/bash

sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install -y build-essential


sudo apt -y purge libpng12-0
sudo apt -y purge libpng12-0:i386
#sudo apt -y purge libfreetype6
#sudo apt -y purge libfreetype6:i386

sudo apt purge libpng12-0 libpng12-0:i386 libfreetype6 libfreetype6:i386
sudo apt-get install -y gcc-multilib g++-multilib \
	lib32z1 lib32stdc++6 lib32gcc1 \
	expat:i386 fontconfig:i386 libexpat1:i386 libc6:i386 libgtk-3-0:i386 \
	libcanberra0:i386 libice6:i386 libsm6:i386 libncurses5:i386 zlib1g:i386 \
	libx11-6:i386 libxau6:i386 libxdmcp6:i386 libxext6:i386 libxft2:i386 libxrender1:i386 \
	libxt6:i386 libxtst6:i386

wget http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_amd64.deb
wget http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_i386.deb
wget http://archive.ubuntu.com/ubuntu/pool/main/f/freetype/libfreetype6_2.6.1-0.1ubuntu2_i386.deb
wget http://archive.ubuntu.com/ubuntu/pool/main/f/freetype/libfreetype6_2.6.1-0.1ubuntu2_amd64.deb
sudo dpkg -i libpng12-0_1.2.54-1ubuntu1.1_amd64.deb libpng12-0_1.2.54-1ubuntu1.1_i386.deb
sudo dpkg -i libfreetype6_2.6.1-0.1ubuntu2_amd64.deb libfreetype6_2.6.1-0.1ubuntu2_i386.deb

rm -f *.deb

# How it get broken 
# sudo apt --fix-broken install
# sudo apt update
