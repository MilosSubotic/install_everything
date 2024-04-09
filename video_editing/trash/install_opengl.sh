#!/bin/bash

#https://www.reddit.com/r/Ubuntu/comments/17od74n/is_there_a_standard_way_to_update_the_intel_gpu/?rdt=42730

#sudo apt update
#sudo apt install linux-oem-22.04d
#sudo reboot
#
#sudo add-apt-repository ppa:kisak/kisak-mesa
#sudo apt update
#sudo apt upgrade


sudo add-apt-repository ppa:oibaf/graphics-drivers
sudo apt update
sudo apt upgrade