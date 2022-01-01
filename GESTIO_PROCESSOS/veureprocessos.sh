#!/bin/bash
echo "Content-Type: text/html"
echo ""
echo -e "	<!DOCTYPE html><html>
			<head><meta http-equiv="Content-Type" content="text/html\; charset=UTF-8" /></head><body>
			<h1>SHOW ALL PROCESSOS</h1>"

			while IFS="" read -r -a line;
			do
				echo -e "<p>$line</p>";
			done <<< "$(ps -aux)"

echo -e 	"<form action="../webapp.sh">
				<input type="submit" value="Return">
			</form>
			</body></html>"
