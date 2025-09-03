#!/bin/bash
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
# Settings.

if [[ "$DIST" == "Ubuntu" ]]
then
    if (( $MAJOR >= 20 ))
    then
        # Above that, they need license.
        VERSION=20.1.1
    elif (( $MAJOR >= 18 ))
    then
        VERSION=19.1
    else
        VERSION=18.0
    fi
else
    # Other dists.
    echo "Not supported distro!"
    exit 2
fi

echo "DIST=$DIST"
echo "MAJOR=$MAJOR"
echo "VERSION=$VERSION"

PREFIX=/opt/intelFPGA/$VERSION

###############################################################################
# Check if we have good version of Quartus downloaded.

C=`ls -w1 Quartus*Setup-$VERSION*-linux.run | wc -l`
if (( $C < 1 ))
then
    echo "You do not have downloaded good Quartus version!"
    echo "You need Quartus $VERSION!"
    exit 1
fi

C=`ls -w1 max10-$VERSION*.qdz | wc -l`
if (( $C < 1 ))
then
    echo "You do not have downloaded MAX10 device file!"
    echo "You need MAX10 $VERSION qdz file!"
    exit 1
fi

###############################################################################
# Check for sudo.

sudo -v
if test $? != 0
then
    echo "You need to have sudo rights to proceed with installation!"
    exit 1
fi

###############################################################################
# Install for ModelSim-Altera to work.

if [[ "$DIST" == "Ubuntu" ]]
then
    sudo dpkg --add-architecture i386
    sudo apt-get update
    sudo apt-get install -y build-essential
    
    if (( $MAJOR < 18 ))
    then
        sudo apt-get -y install \
        libc6:i386 libx11-6:i386 libxext6:i386 libxft2:i386 libncurses5:i386
    elif (( $MAJOR == 18 ))
    then
        # URL: https://askubuntu.com/questions/1121815/how-do-i-run-mentor-modelsim-questa-in-ubuntu-18-04
        sudo apt-get install -y gcc-multilib g++-multilib \
        lib32z1 lib32stdc++6 lib32gcc1 \
        expat:i386 fontconfig:i386 libfreetype6:i386 libexpat1:i386 libc6:i386 libgtk-3-0:i386 \
        libcanberra0:i386 libpng12-0:i386 libice6:i386 libsm6:i386 libncurses5:i386 zlib1g:i386 \
        libx11-6:i386 libxau6:i386 libxdmcp6:i386 libxext6:i386 libxft2:i386 libxrender1:i386 \
        libxt6:i386 libxtst6:i386
        
        wget http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_amd64.deb
        wget http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_i386.deb
        wget http://archive.ubuntu.com/ubuntu/pool/main/f/freetype/libfreetype6_2.6.1-0.1ubuntu2_i386.deb
        wget http://archive.ubuntu.com/ubuntu/pool/main/f/freetype/libfreetype6_2.6.1-0.1ubuntu2_amd64.deb
        sudo dpkg -i libpng12-0_1.2.54-1ubuntu1.1_amd64.deb libpng12-0_1.2.54-1ubuntu1.1_i386.deb
        sudo dpkg -i libfreetype6_2.6.1-0.1ubuntu2_amd64.deb libfreetype6_2.6.1-0.1ubuntu2_i386.deb
        
        rm -f *.deb
    elif (( $MAJOR == 19 ))
    then
        # Do nothing.
        echo "Not implemented Ubuntu version!"
    elif (( $MAJOR == 20 ))
    then
        # URL: https://askubuntu.com/questions/1121815/how-do-i-run-mentor-modelsim-questa-in-ubuntu-18-04
        sudo apt-get install -y gcc-multilib g++-multilib \
            lib32z1 lib32stdc++6 lib32gcc1 \
            expat:i386 fontconfig:i386 libfreetype6:i386 libexpat1:i386 libc6:i386 libgtk-3-0:i386 \
            libcanberra0:i386 libpng16-16:i386 libice6:i386 libsm6:i386 libncurses5:i386 zlib1g:i386 \
            libx11-6:i386 libxau6:i386 libxdmcp6:i386 libxext6:i386 libxft2:i386 libxrender1:i386 \
            libxt6:i386 libxtst6:i386
    elif (( $MAJOR == 22 ))
    then
        #TODO Test
        sudo apt-get install -y gcc-multilib g++-multilib \
            lib32z1 lib32stdc++6 \
            expat:i386 fontconfig:i386 libfreetype6:i386 libexpat1:i386 libc6:i386 libgtk-3-0:i386 \
            libcanberra0:i386 libpng16-16:i386 libice6:i386 libsm6:i386 libncurses5:i386 zlib1g:i386 \
            libx11-6:i386 libxau6:i386 libxdmcp6:i386 libxext6:i386 libxft2:i386 libxrender1:i386 \
            libxt6:i386 libxtst6:i386
    else
        # Other versions.
        echo "Not supported Ubuntu version!"
        #exit 2
    fi
else
    # Other dists.
    echo "Not supported distro!"
    #exit 2
fi

###############################################################################
# Set bash as default shell.

sudo dpkg-reconfigure -p critical dash

if test $SHELL != "/bin/bash"
then
    echo "Cannot set Bash as default shell!"
    exit 1
fi

###############################################################################
# Install Quartus with MAX10

chmod a+x *.run
sudo ./Quartus*Setup-$VERSION*-linux.run \
    --mode unattended \
    --unattendedmodeui minimalWithDialogs \
    --accept_eula 1 \
    --installdir $PREFIX

# Need it for v20 - v21.1
sudo chmod -R a+rX $PREFIX/

###############################################################################
# Install driver for JTAG.

# From "Arrow_USB_Programmer_2.1_linux64.zip".
cd Arrow_USB_Programmer/

# Turn off serial FDTI driver.
sudo rmmod ftdi_sio
sudo rmmod usbserial
echo 'blacklist ftdi_sio' | sudo tee /etc/modprobe.d/blacklist.conf -a
#FIXME This make a problem for Arduino.
#echo 'blacklist usbserial' | sudo tee /etc/modprobe.d/blacklist.conf -a

# Install rules and driver lib.
sudo cp 51-usbblaster.rules /etc/udev/rules.d/
sudo usermod -a -G plugdev $USER
sudo cp arrow_usb_blaster.conf /etc/
sudo install -m 755 libjtag_hw_arrow.so $PREFIX/quartus/linux64/

# Restart udev.
sudo systemctl daemon-reload
sudo systemctl restart udev

cd ..

###############################################################################
# Scripts and path.

sudo cp -r scripts $PREFIX/
sudo chmod 755 $PREFIX/scripts/
sudo chmod 755 $PREFIX/scripts/*

cat >> ~/.profile << EOF

# Quartus stuff.
export PATH=\$PATH:$PREFIX/quartus/bin:$PREFIX/nios2eds:$PREFIX/scripts
EOF

###############################################################################
# Install some utils.

sudo apt-get -y install picocom
# Enable access to /dev/ttyUSB* ports.
sudo usermod -a -G dialout $USER

###############################################################################

echo "To use Quartus, please, log out and then log in."
echo "For some IP cores, like Nios II CPU,"
echo "license is: 1800@licserver-win1"
echo "To test connection with board run: jtagconfig"

###############################################################################

# If Eclipse does not work do:
#sudo apt-get install libgtk2.0-0:i386 libxtst6:i386
#echo "export SWT_GTK3=0" >> ~/.profile

###############################################################################

echo "End"

###############################################################################
