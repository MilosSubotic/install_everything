#!/bin/bash

#https://derushadigital.com/other%20projects/2019/02/19/RPi-USBIP-ZWave.html

sudo apt -y install usbip
sudo modprobe usbip_host
echo 'usbip_host' | sudo tee -a /etc/modules >> /dev/null

sudo mkdir -p /usr/local/sbin/
sudo cp usbipd_service.py /usr/local/sbin/
sudo cp usbipd.service /lib/systemd/system/

# reload systemd, enable, then start the service
sudo systemctl --system daemon-reload
sudo systemctl enable usbipd.service
sudo systemctl start usbipd.service

# For debug:
#/usr/sbin/usbip list -p -l
#systemctl status usbipd.service | less
