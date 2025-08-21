#!/bin/bash

exit 0

#V=2024.1
V=2025.1

# https://support.xilinx.com/s/question/0D52E00006hpmTmSAI/vivado-20183-final-processing-hangs-at-generating-installed-device-list-on-ubuntu-1904?language=en_US
if [[ "$V" == "2024.1" ]]
then
    sudo apt -y install libtinfo5 libncurses5
else
    sudo apt -y install libtinfo6 libncurses6
fi

# Downloaded from site.
sudo bash FPGAs_AdaptiveSoCs_Unified_*${V}*_Lin64.bin
# Setup proxy
# Vitis
# 

if [[ "$V" == "2024.1" ]]
then
    source /tools/Xilinx/Vivado/${V}/settings64.sh
else
    source /tools/Xilinx/${V}/Vivado/settings64.sh
fi

sudo $XILINX_VITIS/scripts/installLibs.sh

if [[ "$V" == "2024.1" ]]
then
    if [[ "$http_proxy" != "" ]]
    then
        #TODO Does it realy need this.
        cat /etc/profile.d/proxy.sh >> ~/.profile
        sudo rm /etc/profile.d/proxy.sh

        #TODO Test this, espec with Vitis and install_brds.sh
        sudo tee -a /tools/Xilinx/Vivado/${V}/settings64.sh << EOF
unset http_proxy
unset https_proxy
EOF
        #mkdir -p ~/.local/bin/
        #cp priv/unproxy_vitis ~/.local/bin/
        #cp priv/unproxy_vivado ~/.local/bin/
    fi
fi