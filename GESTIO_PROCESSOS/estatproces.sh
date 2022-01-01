#!/bin/bash
echo "Content-Type: text/html"
echo ""

aux1=`echo $QUERY_STRING | awk -F= '{print $2}'`
pid=`echo $aux1 | awk -F\& '{print $1}'`
status=`echo "$(ps -q $pid -o state --no-headers)"`

echo -e "	<!DOCTYPE html><html>
			<head><meta http-equiv="Content-Type" content="text/html\; charset=UTF-8" /></head><body>
			<h1>ESTAT DEL PROCES</h1>
			<p>Process status: $status</p>

			<form action="../webapp.sh">
				<input type="submit" value="Return">
			</form>
			</body></html>"
