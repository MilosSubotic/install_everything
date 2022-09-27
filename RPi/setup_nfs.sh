#!/bin/bash

sudo apt -y install nfs-kernel-server
sudo bash -c 'echo "/home/pi/Public       *(rw,sync,no_subtree_check)" >> /etc/exports'
sudo service nfs-kernel-server restart
