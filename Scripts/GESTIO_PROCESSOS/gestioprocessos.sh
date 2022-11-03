#!/bin/bash
echo Content-Type: text/html
echo
echo -e "
<!DOCTYPE html><html>
	<head>
		<meta charset="UTF-8">
		<style>
			@import url('https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap');

			*, *:after, *:before {
				box-sizing: border-box;
			}

			body {
				font-family: "DM Sans", sans-serif;
				line-height: 1.5;
				background-color: #f1f3fb;
				padding: 0 2rem;
			}

			img {
				max-width: 100%;
				display: block;
			}


			// iOS Reset
			input {
				appearance: none;
				border-radius: 0;
			}

			.card {
				margin: 5rem auto;
				display: flex;
				flex-direction: column;
				width: 100%;
				max-width: 425px;
				background-color: #FFF;
				border-radius: 10px;
				box-shadow: 0 10px 20px 0 rgba(#999, .25);
				padding: .75rem;
			}

			.card-image {
				border-radius: 8px;
				overflow: hidden;
				padding-bottom: 65%;
				background-image: url('https://assets.codepen.io/285131/coffee_1.jpg');
				background-repeat: no-repeat;
				background-size: 150%;
				background-position: 0 5%;
				position: relative;
			}

			.card-heading {
				left: 10%;
				top: 15%;
				right: 10%;
				font-size: 1.75rem;
				font-weight: 700;
				color: black;
				line-height: 1.222;
				small {
					display: block;
					font-size: .75em;
					font-weight: 400;
					margin-top: .25em;
				}
			}

			.card-form {
				padding: 0rem 1rem 0;
			}

			.input {
				display: flex;
				flex-direction: column-reverse;
				position: relative;
				padding-top: 1.5rem;
				&+.input {
					margin-top: 1.5rem;
				}
			}

			.input-label {
				color: #8597a3;
				top: 1.5rem;
				transition: .25s ease;
			}

			.input-field {
				border: 0;
				z-index: 1;
				background-color: transparent;
				border-bottom: 2px solid #eee;
				font: inherit;
				font-size: 1.125rem;
				padding: .25rem 0;
				&:focus, &:valid {
					outline: 0;
					border-bottom-color: #6658d3;
					&+.input-label {
						color: #6658d3;
						transform: translateY(-1.5rem);
					}
				}
			}

			.action {
				margin-top: 2rem;
			}

			.action-top {
				margin-top: 0rem;
			}

			.action-button {
				font: inherit;
				padding: 0.35em;
				width: 100%;
				font-weight: 500;
				background-color: #6658d3;
				border-radius: 6px;
				color: #FFF;
				border: 0;
				&:focus {
					outline: 0;
				}
			}

			.action-button:hover {
				background-color: #97a7e5;
			}

			.action-button2 {
				font: inherit;
				padding: 1em;
				font-weight: 500;
				background-color: #c0caf3;
				border-radius: 6px;
				color: #FFF;
				border: 0;
				&:focus {
					outline: 0;
				}
			}

			.action-button2:hover {
				background-color: #6658d3;
			}

			.card-info {
				padding: 1rem 1rem;
				text-align: center;
				font-size: .875rem;
				color: #8597a3;
				a {
					display: block;
					color: #6658d3;
					text-decoration: none;
				}
			}

			.center{
				text-align: center;
			}

			hr{
				width: 90%;
				margin: auto;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<div class="card">
				<div class="center"><h2 class="card-heading">Gestió de Processos</h2></div>

				<div class="center"><h3>Veure tots els processos</h3></div>
				<form action="veureprocessos.sh" class="card-form">
					<div class="action-top">
						<input class="action-button" type="submit" value=\"Mostra\">
					</div>
				</form>

				</br>
				</br>
				<hr>
				</br>

				<div class="center"><h3>Consulta estat procés</h3></div>
				<form action="estatproces.sh" class="card-form">
					<div class="input">
						<input type="text" class="input-field" name="name" required/>
						<label class="input-label">PID</label>
					</div>
					<div class="action">
						<input class="action-button" type="submit" value="Consulta">
					</div>
				</form>

				</br>
				</br>
				<hr>
				</br>

				<div class="center"><h3>Elimina un procés</h3></div>
				<form action="eliminarproces.sh" class="card-form">
					<div class="input">
						<input type="text" class="input-field" name="name" required/>
						<label class="input-label">PID</label>
					</div>
					<div class="action">
						<input class="action-button" type="submit" value="Elimina">
					</div>
				</form>

				</br>
				</br>
				<hr>
				</br>

				<div class="center"><h3>Elimina un procés en segons</h3></div>
				<form action="eliminarprocessegons.sh" class="card-form">
					<div class="input">
						<input type="text" class="input-field" name="name" required/>
						<label class="input-label">PID</label>
					</div>
					<div class="input">
						<input type="text" class="input-field" name="temps" required/>
						<label class="input-label">Temps</label>
					</div>
					<div class="action">
						<input class="action-button" type="submit" value="Elimina">
					</div>
				</form>

				</br>
				</br>
				<div class="card-info">
					<p>Tornar al inici</p>
					<div class="action">
						<form action="../webapp.sh">
								<input class="action-button2" type="submit" value="Tornar">
						</form>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>"
