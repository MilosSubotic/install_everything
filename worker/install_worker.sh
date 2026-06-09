#!/bin/bash
###############################################################################

sudo -E apt -y install worker
sudo -E apt -y install p7zip-full cdparanoia

sudo cp backup /usr/local/bin/

echo 'export WORKER_XEDITOR=code' >> ~/.profile

./update_worker_config.sh

###############################################################################
