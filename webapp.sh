#!/bin/bash
echo "Content-Type: text/html"
echo ""
echo -e "	<!DOCTYPE html><html>
			<head><meta http-equiv="Content-Type" content="text/html\; charset=UTF-8" /></head><body>
			<h1>WEB APP</h1>

			<form action="GESTIO_PROCESSOS/gestioprocessos.sh">
				<input type="submit" value="GestioProcessos">
			</form>

			<form action="MONOTORITZACIO/monotoritzacio.sh">
				<input type="submit" value="Monotoritzacio">
			</form>

			<form action="GESTIO_LOGS/gestiologs.sh">
				<input type="submit" value="GestioLogs">
			</form>

			<form action="GESTIO_USUARIS/gestiousuaris.sh">
				<input type="submit" value="GestioUsuaris">
			</form>

			<form action="FILTRAT_PAQUETS/filtratpaquets.sh">
				<input type="submit" value="FiltratPaquets">
			</form>

			<form action="CRON/cron.sh">
				<input type="submit" value="Cron">
			</form>

			<form action="MUSICA/musica.sh">
				<input type="submit" value="Musica">
			</form>

			<form action="APAGAR/apagar.sh">
				<input type="submit" value="Apagar">
			</form>

			<form action="REINICIAR/reiniciar.sh">
				<input type="submit" value="Reiniciar">
			</form>
		</body></html>"
