#!/bin/bash
echo Content-Type: text/html
echo

#@TODO

echo -e "	<!DOCTYPE html><html>
		<body>
			<h1>FILTRAT PAQUETS</h1>

            <form action="" method="get" ENCTYPE="text/plain">
			Name: <input type="text" name="name" size="20">
			<input type="submit" value="Filtrar">
            </form>

            <form action="" method="get" ENCTYPE="text/plain">
			Source IP: <input type="text" name="name" size="20">
			<input type="submit" value="Filtrar">
            </form>

            <form action="" method="get" ENCTYPE="text/plain">
			Destiny IP: <input type="text" name="name" size="20">
			<input type="submit" value="Filtrar">
            </form>

            <form action="" method="get" ENCTYPE="text/plain">
			Port: <input type="text" name="name" size="20">
			<input type="submit" value="Filtrar">
            </form>

            <form action="../webapp.sh">
                <input type="submit" value="Return">
            </form>
		</body>
		</html>"
