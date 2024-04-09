#!/bin/bash

./install_everything_on_Ubuntu.sh
./campus/setup_proxy_Ubuntu.sh
./campus/setup_proxy_arduino.sh

sudo apt -y install wireshark