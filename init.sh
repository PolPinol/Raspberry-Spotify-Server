#!/bin/bash
sudo apt install raspberrypi-kernel-headers
sudo apt-get install git
git clone https://github.com/PolPinol/aso_fase1.git
cd $HOME/aso_fase1
make clean
make
sudo insmod led.ko