<!doctype html>
<html lang="pt-BR">
<head>

	<meta charset="utf-8">
	<title>Teste de Login</title>
	
	<link rel="stylesheet" type="text/css" href="css/clearcut.css">
	
	<style>
	
		body {
			margin: 0;
			background: #f5f5f5;
		}
	
		#janela {
			margin: 30px auto;
			width: 500px;
		}
		
		#pagina {
		}
		
		h1 {
			text-align: center !important;
		}
		
	</style>
	
</head>
<body class="clearcut">

	<div id="janela">

		<form id="pagina" action="ctrl.login.php" method="post" class="ajax">
		
			<h1>Login</h1>
		
			<div class="fieldset">

				<?php /*
				<label for="form-email">E-mail:</label>
				<input id="form-email" name="email" type="email">
				*/ ?>
				
				<p>
				
				<label for="form-username">Nome do usuário:</label>
				<input id="form-username" name="username" type="text" class="input-text">
				
				</p>
				<p>
				
				<label for="form-password">Senha:</label>
				<input id="form-password" name="password" type="password" class="input-text">
				
				</p>
				<p>
				
					<button id="form-submit" name="submit" type="submit" class="button button-submit">Login</button>
				
				</p>
			
			</div>
		
		</form>

	</div>

<script src="jquery-1.11.0.min.js"></script>
<script src="ajaxform-lite.js"></script>
	
</body>
</html>