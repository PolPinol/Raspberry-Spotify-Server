#!/bin/bash

echo Content-Type: text/html
echo
echo -e "<!DOCTYPE html><html><body>"

aux1=`echo $QUERY_STRING | awk -F= '{print $2}'`
name=`echo $aux1 | awk -F\& '{print $1}'`

if [ `id -u $name 2>/dev/null || echo -1` -ge 0 ];
then
	echo -e "	<h1>REMOVE USER</h1>
				<p>Removed successful</p>
				<form action="../webapp.sh">
					<input type="submit" value="Continue">
				</form>"
				sudo userdel $name
				sudo rm -rf /home/$name
else
	echo -e "	<h1>REMOVE USER</h1>
				<p>User doesn't exist.</p>
				<form action="../webapp.sh">
					<input type="submit" value="Return">
				</form>"
fi
echo -e "</body></html>"
