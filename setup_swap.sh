#!/bin/bash

cat /proc/sys/vm/swappiness

cat << EOF | sudo tee -a /etc/sysctl.conf
vm.swappiness=10
EOF

sudo sysctl --load=/etc/sysctl.conf 

cat /proc/sys/vm/swappiness
