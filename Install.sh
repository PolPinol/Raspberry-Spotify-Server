#!/bin/bash

sudo apt update

sudo apt install raspberrypi-kernel-headers

#TODO: demana el 'Y'
sudo apt install apache2

sudo apt-get install xrdp
sudo a2enmod cgid
sudo systemctl restart apache2

#TODO: Instalem git per crear els scripts al lloc corresponent
sudo apt-get install git
git clone https://github.com/PolPinol/Raspberry_Spotify_Server $HOME/Desktop
cd $HOME/Desktop && git checkout dev

cd $HOME/Desktop/code && make && sudo insmod LKM.ko && cp A.sh /home/pi/A.sh && cp B.sh /home/pi/B.sh && cp C.sh /home/pi/C.sh && cp D.sh /home/pi/D.sh && chmod +x /home/pi/A.sh /home/pi/B.sh /home/pi/C.sh /home/pi/D.sh

sudo cp -r $HOME/Desktop/* /usr/lib/cgi-bin

sudo chmod -R 755 /usr/lib/cgi-bin
echo 'www-data ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo

#Per transofrmar \n s de Windows a format Unix
sudo apt-get install dos2unix
cd /usr/lib/cgi-bin && sudo find . -type f -print0 | sudo  xargs -0 dos2unix

#Instalem les iptables
sudo apt-get install iptables

#Instalem el mpg123
sudo apt-get install mpg123

touch /home/pi/Desktop/logs.txt
sudo chmod 777 /home/pi/Desktop/logs.txt

touch /home/pi/Downloads/currentsong.txt
sudo chmod 777 /home/pi/Downloads/currentsong.txt
echo "1" > /home/pi/Downloads/currentsong.txt

touch /home/pi/Downloads/llista.txt
sudo chmod 777 /home/pi/Downloads/llista.txt
echo "1 song1.mp3" > /home/pi/Downloads/llista.txt
echo "2 song2.mp3" >> /home/pi/Downloads/llista.txt
echo "3 song3.mp3" >> /home/pi/Downloads/llista.txt
echo "4 song4.mp3" >> /home/pi/Downloads/llista.txt

sudo systemctl restart apache2



