#!/bin/bash

sudo mkdir -p /opt/esp-idf/
sudo chmod 777 /opt/esp-idf/

git clone -b v4.3 --recursive https://github.com/espressif/esp-idf.git
sudo mv esp-idf /opt/esp-idf/v4.3

pushd /opt/esp-idf/v4.3/
./install.sh
popd