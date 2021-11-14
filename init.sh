#!/bin/bash
sudo apt install raspberrypi-kernel-headers
sudo apt-get install git
git clone https://github.com/PolPinol/aso_fase1.git
cd $HOME/aso_fase1
chmod +777 button1.sh
chmod +777 button2.sh
chmod +777 button3.sh
chmod +777 button4.sh
make
sudo insmod led.ko
