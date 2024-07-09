#!/bin/bash

exit 0

V=2024.1

# https://support.xilinx.com/s/question/0D52E00006hpmTmSAI/vivado-20183-final-processing-hangs-at-generating-installed-device-list-on-ubuntu-1904?language=en_US
sudo apt -y install libtinfo5 libncurses5

# Download from site.
sudo bash FPGAs_AdaptiveSoCs_Unified_${V}*_Lin64.bin 

source /opt/Xilinx/Vivado/${V}/settings64.sh

sudo $XILINX_VITIS/scripts/installLibs.sh