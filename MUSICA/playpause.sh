#!/bin/bash
echo "Content-Type: text/html"
echo ""
echo -e "	<!DOCTYPE html><html>
			<head><meta http-equiv="Content-Type" content="text/html\; charset=UTF-8" /></head><body>
			<h1>PLAY/PAUSE</h1>

            <form action="../webapp.sh">
                <input type="submit" value="Return">
            </form>
		</body></html>"
