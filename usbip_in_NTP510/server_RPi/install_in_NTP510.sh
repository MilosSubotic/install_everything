#!/bin/bash

D=`dirname "${BASH_SOURCE[0]}"`

bash $D/../../RPi/install_everything_in_NTP510.sh
bash $D/install.sh
