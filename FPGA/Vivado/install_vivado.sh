#!/bin/bash

exit 0

V=2024.1

# https://support.xilinx.com/s/question/0D52E00006hpmTmSAI/vivado-20183-final-processing-hangs-at-generating-installed-device-list-on-ubuntu-1904?language=en_US
sudo apt -y install libtinfo5 libncurses5

# Downloaded from site.
sudo bash FPGAs_AdaptiveSoCs_Unified_${V}*_Lin64.bin 

source /opt/Xilinx/Vivado/${V}/settings64.sh

sudo $XILINX_VITIS/scripts/installLibs.sh

if [[ "$V" == "2024.1" ]]
then
    if [[ "$http_proxy" != "" ]]
    then
        #TODO Does it realy need this.
        cat /etc/profile.d/proxy.sh >> ~/.profile
        sudo rm /etc/profile.d/proxy.sh

        #TODO Test this, espec with Vitis and install_brds.sh
        sudo tee -a /opt/Xilinx/Vivado/${V}/settings64.sh << EOF
unset http_proxy
unset https_proxy
EOF
        #mkdir -p ~/.local/bin/
        #cp priv/unproxy_vitis ~/.local/bin/
        #cp priv/unproxy_vivado ~/.local/bin/
    fi
fi