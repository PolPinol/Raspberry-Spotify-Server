#!/bin/bash
echo Content-Type: text/html
echo
echo -e "	<!DOCTYPE html><html>
		<body>
			<p>Reiniciando...</p>

            <form action="../index.sh">
                <input type="submit" value="Return">
            </form>
		</body>
		</html>"

sudo reboot
