#!/bin/bash
echo Content-Type: text/html
echo
echo -e "	<!DOCTYPE html><html>
		<body>
			<h1>GESTIO D'USUARIS'</h1>

            <form action="veuretotsusuaris.sh" method="get" ENCTYPE="text/plain">
			<input type="submit" value="VeureTotsUsuaris">
            </form>

			<form action="afegirusuari.sh" method="get" ENCTYPE="text/plain">
			Name: <input type="text" name="name" size="20">
            Password: <input type="password" name="temps" size="20">
			<input type="submit" value="AfegirUsuari">
            </form>

            <form action="eliminarusuari.sh" method="get" ENCTYPE="text/plain">
			Name: <input type="text" name="name" size="20">
			<input type="submit" value="EliminarUsuari">
            </form>

            <form action="../webapp.sh">
                <input type="submit" value="Return">
            </form>
		</body>
		</html>"
