#!/bin/bash

sudo pkill -9 -f mpg123
sudo pkill -9 -f reproduir.sh
nohup bash /usr/lib/cgi-bin/MUSICA/reproduir2.sh > /dev/null 2>&1 & disown
sudo chmod 777 /home/pi/Downloads/pipe
nohup bash /usr/lib/cgi-bin/MUSICA/reproduir.sh > /dev/null 2>&1 & disown
