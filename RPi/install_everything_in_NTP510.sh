#!/bin/bash

D=`dirname "${BASH_SOURCE[0]}"`

sudo cp $D/static_ip_settings /etc/network/interfaces.d
sudo service networking restart
bash $D/../campus/setup_proxy_basic.sh
