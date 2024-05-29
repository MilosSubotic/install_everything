#!/bin/bash

D=`dirname "${BASH_SOURCE[0]}"`

sudo cp $D/proxy.sh /etc/profile.d/proxy.sh
sudo cp $D/10proxy /etc/apt/apt.conf.d/10proxy
sudo apt update

# If need immidiately to use it.
source /etc/profile.d/proxy.sh

