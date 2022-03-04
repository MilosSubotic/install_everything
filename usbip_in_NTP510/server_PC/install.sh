#!/bin/bash

sudo apt -y install linux-tools-generic
sudo ln -s /usr/lib/linux-tools/5.4.0-100-generic/usbip /usr/local/bin/usbip

sudo modprobe vhci-hcd
echo 'vhci-hcd' | sudo tee -a /etc/modules >> /dev/null

sudo cp usbip.service /lib/systemd/system/usbip.service

sudo systemctl --system daemon-reload
sudo systemctl enable usbip.service
sudo systemctl start usbip.service

# For debug:
# systemctl status usbip.service | less
# lsusb