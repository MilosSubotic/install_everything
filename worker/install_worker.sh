#!/bin/bash
###############################################################################

sudo apt -y install worker
sudo apt -y install p7zip-full cdparanoia

sudo cp backup /usr/local/bin/

echo 'export WORKER_XEDITOR=code' >> ~/.profile

./update_worker_config.sh

###############################################################################
