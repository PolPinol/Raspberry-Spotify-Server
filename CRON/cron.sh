#!/bin/bash
echo Content-Type: text/html
echo
echo -e "	<!DOCTYPE html><html>
		<body>
			<h1>GESTIO DE CRONS</h1>

            <form action="veuretotscrons.sh" method="get" ENCTYPE="text/plain">
			<input type="submit" value="VeureTotsCrons">
            </form>

            <form action="afegircron.sh" method="get" ENCTYPE="text/plain">
			Name: <input type="text" name="name" size="20">
			<input type="submit" value="AfegirCron">
            </form>

            <form action="eliminarcron.sh" method="get" ENCTYPE="text/plain">
			Name: <input type="text" name="name" size="20">
			<input type="submit" value="BorrarCron">
            </form>

            <form action="../webapp.sh">
                <input type="submit" value="Return">
            </form>
		</body>
		</html>"
