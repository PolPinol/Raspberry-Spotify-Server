#!/bin/bash
echo Content-Type: text/html
echo
echo -e "	<!DOCTYPE html><html>
		<body>
			<p>Apagando...</p>

            <form action="../index.sh">
                <input type="submit" value="Return">
            </form>
		</body>
		</html>"

sudo shutdown now
