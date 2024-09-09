#!/bin/bash

./campus/setup_proxy_Ubuntu.sh
./on_Ubuntu.sh
./campus/setup_proxy_arduino.sh

#FIXME Need to select YES
sudo apt -y install wireshark
