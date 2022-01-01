#!/bin/bash
echo Content-Type: text/html
echo

#@TODO
#crons=`echo "$(for user in $(sudo cut -f1 -d: /etc/passwd); do sudo crontab -u $user -l; done)"`

echo -e "	<!DOCTYPE html><html>
		<body>
			<h1>SHOW ALL CRONS FOR EACH USER</h1>"

			line=`echo "$(crontab -l)"`
			while IFS="" read -r -a line2;
			do
				echo "<p>$line2</p>";
			done <<< "$line"

echo -e "	<form action="../webapp.sh">
                <input type="submit" value="Return">
            </form>
		</body>
		</html>"
