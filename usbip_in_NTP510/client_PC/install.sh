#!/bin/bash

sudo apt -y install linux-tools-`uname -r`
sudo cp usbip /usr/local/bin/usbip

sudo modprobe vhci-hcd
echo 'vhci-hcd' | sudo tee -a /etc/modules >> /dev/null

sudo mkdir -p /usr/local/sbin/
sudo cp usbip_service.py /usr/local/sbin/
sudo mkdir -p /usr/local/share/usbip_services
sudo cp ../common/settings.csv /usr/local/share/usbip_services
sudo cp usbip.service /lib/systemd/system/


sudo systemctl --system daemon-reload
sudo systemctl enable usbip.service
sudo systemctl start usbip.service

# For debug:
# systemctl status usbip.service | less
# lsusb