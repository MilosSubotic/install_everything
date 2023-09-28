#!/bin/bash

cat /proc/sys/vm/swappiness

cat | sudo tee -a /etc/sysctl.conf << EOF
vm.swappiness=10
EOF

sudo sysctl --load=/etc/sysctl.conf 

cat /proc/sys/vm/swappiness
