#!/bin/bash

sudo apt -y install python3-venv

sudo mkdir -p /opt/esp-idf/
sudo chmod 777 /opt/esp-idf/

pushd /opt/esp-idf/
git clone -b v5.4 --recursive https://github.com/espressif/esp-idf.git v5.4

export IDF_TOOLS_PATH=/opt/esp-idf/tools
sed -i '2i\export IDF_TOOLS_PATH=/opt/esp-idf/tools\' /opt/esp-idf/v5.4/export.sh 

pushd /opt/esp-idf/v5.4/
./install.sh esp32c6
popd


popd