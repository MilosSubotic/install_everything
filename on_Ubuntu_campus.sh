#!/bin/bash

./campus/setup_proxy_Ubuntu.sh
./on_Ubuntu.sh
./campus/setup_proxy_arduino.sh

sudo apt -y install wireshark
