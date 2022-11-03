#!/bin/bash
sudo pkill -9 -f reproduir.sh
nohup bash /usr/lib/cgi-bin/MUSICA/reproduir.sh 1 > /dev/null 2>&1 & disown
