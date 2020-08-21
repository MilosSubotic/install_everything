#!/bin/bash
###############################################################################

sudo apt -y install worker
sudo apt -y install p7zip-full cdparanoia

echo 'export WORKER_XEDITOR=atom' >> ~/.profile

./update_worker_config.sh

###############################################################################
