#!/bin/bash

sudo cp static_ip_settings /etc/network/interfaces.d
sudo service networking restart
bash install_everything_on_campus.sh
