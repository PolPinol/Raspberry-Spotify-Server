#!/bin/bash
echo Content-Type: text/html
echo
echo -e "	<!DOCTYPE html><html><body>
			<h1>LOG IN</h1>

			<form action="tryLogin.sh" method="get" ENCTYPE="text/plain">
			Name: <input type="text" name="name" size="20">
			<br/>
			Password: <input type="password" name="password" size="20">
			<br/>
			<input type="submit" value="submit">
			</form>
		</body></html>"
