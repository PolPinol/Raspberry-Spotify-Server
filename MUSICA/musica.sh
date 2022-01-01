#!/bin/bash
echo "Content-Type: text/html"
echo ""
echo -e "	<!DOCTYPE html><html>
			<head><meta http-equiv="Content-Type" content="text/html\; charset=UTF-8" /></head><body>
			<h1>MÚSICA</h1>

			<form action="playpause.sh">
				<input type="submit" value="PlayPause">
			</form>

			<form action="avansarretrocedir.sh">
				<input type="submit" value="AvançarRetrocedir">
			</form>

			<form action="llista.sh">
				<input type="submit" value="LlistaReproducció">
			</form>

			<form action="shuffle.sh">
				<input type="submit" value="Shuffle">
			</form>

			<form action="replay.sh">
				<input type="submit" value="Replay">
			</form>

            <form action="../webapp.sh">
                <input type="submit" value="Return">
            </form>
		</body></html>"
