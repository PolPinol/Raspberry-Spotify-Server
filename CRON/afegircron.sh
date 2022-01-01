#!/bin/bash
echo Content-Type: text/html
echo

#@TODO

aux1=`echo $QUERY_STRING | awk -F= '{print $2}'`
cron=`echo $aux1 | awk -F\& '{print $1}'`
#(crontab -l ; echo "$cron") | sort - | uniq - | crontab - >> /dev/null 2>&1

sudo crontab -l > cron_bkp
sudo echo "$cron >/dev/null 2>&1" >> cron_bkp
sudo crontab cron_bkp
sudo rm cron_bkp

echo -e "	<!DOCTYPE html><html>
		<body>
			<h1>AFEGIR CRON</h1>
			<p>Cron afegit.</p>

            <form action="../webapp.sh">
                <input type="submit" value="Return">
            </form>
		</body>
		</html>"
