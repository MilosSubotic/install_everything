#!/bin/bash

if [ "$XILINX_VIVADO" == "" ]
then
	echo "ERROR: Source Vivado script!"
	exit 1
fi

VIVADO=`dirname $XILINX_VIVADO`
XILINX=`dirname $VIVADO`

echo "Install at: $XILINX"

D="$XILINX/xhub"
V=`basename $XILINX_VIVADO`

sudo mkdir -p $D
sudo chmod 777 $D

vivado -mode gui -script priv/install_brds.tcl

patch -p1  \
    -d $D/board_store/xilinx_board_store/XilinxBoardStore/Vivado/$V/ \
    < priv/preset.xml.patch


