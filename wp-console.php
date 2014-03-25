<?php

/*
 * WordPress Console
 * by a very handsome bunny who can code pretty well, for a bunny
 */

require 'wp-blog-header.php';

$WPC_titulo = htmlentities( get_option('blogname'), ENT_QUOTES, 'UTF-8' ) . '&ensp;&diam;&ensp;WordPress Console';
$WPC_comando = '';

//ini_get('magic_quotes_gpc');

if ( !empty( $_POST ) ) {

	$WPC_comando = stripslashes( $_POST['comando'] );

}

?>
<!doctype html>
<html>
<head>

	<meta charset="utf-8">
	<title><?php print $WPC_titulo ?></title>
	
	<style>
	
		* {
			box-sizing: border-box;
		}
	
		body {
			margin: 1em;
			background: black;
			font-family: 'Lucida Console', 'Courier New', monospace;
			font-size: 16px;
			line-height: 1.25em;
			color: #0C0;
		}
	
		.page {
			margin: 0 auto;
			max-width: 970px;
		}
	
		h1 {
			margin: 2em 0 1em;
			text-align: center;
			font-size: 24px;
			color: #090;
		}
		
		form {
			text-align: center;
		}
		
		textarea {
			margin: 0.5em;
			width: 100%;
			height: 16em;
			border: 4px solid #090;
			background: black;
			padding: 0.5em;
			font: inherit;
			color: inherit;
		}
		
		button {
			-webkit-appearance: none;
			-moz-appearance: none;
			outline: none;
			margin: 0;
			border: none;
			padding: 0.5em 1em;
			box-shadow: none;
			background: #090;
			font: inherit;
			color: black;
			cursor: pointer;
		}
		
			button:hover {
				background-color: #0c0;
			}
			
			button:focus,
			button:active {
				background-color: #999;
			}
		
		pre {
			margin: 0.5em;
			width: 100%;
			border: 4px solid #090;
			background: black;
			padding: 0.5em;
			white-space: pre-wrap;
			font: inherit;
			/*font-weight: bold !important;*/
		}
	
	</style>
	
</head>
<body>

	<div class="page">

		<h1>&ensp;&diam;&ensp;<?php print $WPC_titulo ?>&ensp;&diam;&ensp;</h1>
		
		<form action="<?php print $_SERVER['PHP_SELF'] ?>" method="post" accept-charset="utf-8" enctype="application/x-www-form-urlencoded">
		
			<textarea name="comando"><?php if ( $WPC_comando ) print htmlentities( $WPC_comando, ENT_QUOTES, 'UTF-8' ); ?></textarea>
			<button type="submit">Executar</button>
		
		</form>
		
		<pre><?php

		if ( $WPC_comando ) {

			eval( $WPC_comando );

		} else {
		
			print 'Aguardando...';
		
		}

		?></pre>
	
	</div>

</body>
</html>