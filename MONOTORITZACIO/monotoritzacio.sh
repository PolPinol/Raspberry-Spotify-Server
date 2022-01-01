#!/bin/bash
echo Content-Type: text/html
echo

cpuusage=`echo "CPU Load: "$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]"%"`
memusage=`free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'`
auxlogs=`echo "$(sudo cat /var/log/auth.log | grep Accepted | awk 'NR==1,NR==10 {printf "%s %s %s\n", $1,$2,$3}')"`
uptime=`echo "Server "$(uptime -p)`
diskusage=`df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'`


echo -e "	<!DOCTYPE html><html>
		<body>
			<h1>MONOTORITZACIO</h1>
            <p>$cpuusage</p>
            <p>$memusage</p>
            <p>$diskusage</p>
            <p>$uptime</p></br>
            <p>Last 10 logs on server:</p>"

            while IFS="" read -r -a line;
			do
				echo "<p>$line</p>";
			done <<< "$auxlogs"

            echo -e "<form action="../webapp.sh">
                <input type="submit" value="Return">
            </form>
		</body>
		</html>"
