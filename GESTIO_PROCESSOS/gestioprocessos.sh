#!/bin/bash
echo Content-Type: text/html
echo
echo -e "	<!DOCTYPE html><html>
		<body>
			<h1>GESTIO DE PROCESSOS</h1>

			<form action="veureprocessos.sh" method="get" ENCTYPE="text/plain">
			<input type="submit" value="VeureProcessos">
			</form>

            <form action="estatproces.sh" method="get" ENCTYPE="text/plain">
			PID: <input type="text" name="name" size="20">
			<input type="submit" value="EstatProces">
            </form>

            <form action="eliminarproces.sh" method="get" ENCTYPE="text/plain">
			PID: <input type="text" name="name" size="20">
			<input type="submit" value="EliminarProces">
            </form>

            <form action="eliminarprocessegons.sh" method="get" ENCTYPE="text/plain">
			PID: <input type="text" name="name" size="20">
            TEMPS: <input type="text" name="temps" size="20">
			<input type="submit" value="Eliminar Per Segons">
            </form>

            <form action="../webapp.sh">
                <input type="submit" value="Return">
            </form>
		</body>
		</html>"
