#!/bin/bash
echo "Content-Type: text/html"
echo ""

aux1=`echo $QUERY_STRING | awk -F= '{print $2}'`
pid=`echo $aux1 | awk -F\& '{print $1}'`

echo -e "	<!DOCTYPE html><html>
			<head><meta http-equiv="Content-Type" content="text/html\; charset=UTF-8" /></head><body>
			<h1>ELIMINAR EL PROCES</h1>"

			if [ -n "$(ps -p $pid -o pid=)" ];
			then
				sudo kill -9 $pid
			   	echo -e "<p>Process with PID $pid has been killed.</p>"
		    else
				echo -e "<p>Process with PID $pid is not running.</p>"
			fi

echo -e "<form action="../webapp.sh">
				<input type="submit" value="Return">
			</form>
			</body></html>"
