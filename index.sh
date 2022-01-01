#!/bin/bash
echo Content-Type: text/html
echo
echo -e "	<!DOCTYPE html><html>
		<body>
			<h1>Inici APP</h1>

			<form action="LOGIN/login.sh">
				<input type="submit" value="LogIn">
			</form>

			<form action="SIGNUP/signup.sh">
				<input type="submit" value="SignUp">
			</form>
		</body>
		</html>"
