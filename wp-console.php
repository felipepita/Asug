<?php

/*
 * WordPress Console - build 2
 * by a very handsome bunny who can code pretty well, for a bunny
 */
 
 
 
// Define as variáveis e funções principais dentro de uma classe estática para não poluir o escopo global
 
class WPC {

	static public $listaDiretorios = array();
	static public $arrayDiretorios = array();
	static public $comando = '';
	static public $raiz = '';
	static public $diretorio = '.';
	static public $incPath = '';
	static public $include = '';
	static public $arquivoInclude = '';
	static public $erro = '';
	static public $framework = '';
	static public $html = '';
	static public $nomeSite = '';
	static public $titulo = '';
	
	static public function trim( $string ) {
		// Remove as barras e pontos do início e do final de um caminho
		return trim( $string, ' /\\.' );
	}
	
	static public function esc( $string ) {
		// Escapa as entidades
		return htmlentities( $string, ENT_QUOTES, 'UTF-8' );
	}

	static public function init() {
	
		// Prepara para a execução

		//ini_get('magic_quotes_gpc');
	
		// Obtém os dados do formulário

		if ( !empty( $_POST ) ) {

			if ( isset( $_POST['comando'] ) )
				self::$comando = stripslashes( $_POST['comando'] );
				
			if ( isset( $_POST['include'] ) )
				self::$include = self::trim( stripslashes( $_POST['include'] ) );
				
			if ( isset( $_POST['diretorio'] ) ) {
				self::$diretorio = self::trim( stripslashes( $_POST['diretorio'] ) );
				if ( !self::$diretorio )
					self::$diretorio = '.';
			}

		}
		
		// Define o diretório atual
		
		self::$raiz = self::trim( getcwd() );

		if ( !file_exists( self::$diretorio ) || !is_dir( self::$diretorio ) ) {
			self::$erro .= "Diretório inexistente: \"" . self::$diretorio . "\"." . PHP_EOL;
			self::$diretorio = '.';
		}
		
		self::$incPath = self::trim( realpath( self::$raiz . '/' . self::$diretorio ) );

		$dir = @opendir( self::$diretorio );

		// Lista os subdiretórios

		while ( $dir && false !== ( $entrada = readdir( $dir ) ) ) {
		
			// Gera o caminho relativo à raíz
			$pathEntrada = ( self::$diretorio != '.' ? self::$diretorio . '/' : '' ) . $entrada;
	
			// Pula arquivos e não permite subir a um diretório acima da raíz
			if ( is_file( $pathEntrada ) || $entrada == '..' && self::$diretorio == '.' )
				continue;
			
			// Determina o framework da entrada e gera o <option> para a lista
			$option = self::processarEntrada( $entrada, $pathEntrada );
			
			// Salva na array
			self::$arrayDiretorios[] = $entrada;
			
			// Salva o <option> na lista
			if ( $entrada == '..' ) {
				// Insere essa entrada acima da primeira da lista
				array_unshift( self::$listaDiretorios, $option );
				// Se não estamos na raíz, cria também uma entrada para a raíz
				if ( $pathEntrada ) {
					$entrada = '';
					$pathEntrada = '.';
					$option = self::processarEntrada( $entrada, $pathEntrada );
					array_unshift( self::$listaDiretorios, $option );
				}
			} else {
				// Insere esse entrada por último na lista
				self::$listaDiretorios[] = $option;
			}
				
		}
		
		// Achata a lista
		self::$listaDiretorios = implode( PHP_EOL, self::$listaDiretorios );
		
		// Muda para o diretório de execução
		if ( self::$diretorio != '.' )
			chdir( self::$diretorio );

		// Salva o nome do arquivo de inclusão
		if ( self::$include )
			self::$arquivoInclude = ( self::$incPath ? self::$incPath . '/' : '' ) . self::$include;

		// A inclusão em si deverá ser feita fora desta função para que as variáveis sejam definidas no escopo global
		return;
			
	}
	
	static public function processarEntrada( $entrada, &$pathEntrada ) {
	
			// Processa a entrada e gera o <option> para a lista

			// Determina o framework utilizado nessa entrada
			
			if ( file_exists( "$pathEntrada/wp-blog-header.php" ) ) {
				$framework = 'wp-blog-header.php';
				$nomeFramework = 'WordPress';
			} elseif ( file_exists( "$pathEntrada/mage" ) ) {
				$framework = 'app/Mage.php';
				$nomeFramework = 'Magento';
			} elseif ( file_exists( "$pathEntrada/administrator/" ) ) {
				$framework = 'includes/defines.php';
				$nomeFramework = 'Joomla';
			} elseif ( file_exists( "$pathEntrada/index.php" ) ) {
				$framework = 'index.php';
				$nomeFramework = 'PHP';
			} else {
				$framework = '';
				$nomeFramework = '';
			}
			
			$selected = '';
			
			if ( $entrada == '.' ) {
				// Se for a entrada do dir atual, salva as informações para utilizar no include
				$selected = ' selected';
				if ( !self::$include )
					self::$include = $framework;
				self::$framework = $nomeFramework;
			} elseif ( $entrada == '..' ) {
				// Se for um diretório acima, corrige o caminho
				$pathEntrada = preg_replace( '#(?:^|/)[^/]*?/\.\.$#', '', $pathEntrada );
			}
			
			$pathEntrada = preg_replace( '#\.$#', '', $pathEntrada );
			
			// Gera o <option> e retorna-o
			return "\t<option value='$pathEntrada' data-framework='$framework'$selected>/$pathEntrada" . ( $nomeFramework ? " ($nomeFramework)" : '' ) . "</option>";
	
	}
	
	static public function postInit() {
	
		// Determina o nome do site e define o título da página, dependendo do framework carregado

		switch ( self::$framework ) {
			case 'WordPress' :
				self::$nomeSite = get_option('blogname');
			break;
			case 'Magento' :
				self::$nomeSite = Mage::app()->getStore()->getName();
			break;
			case 'Joomla' :
				self::$nomeSite = JFactory::getApplication()->getCfg( 'sitename' );
			break;
			case 'PHP' :
				if ( preg_match( '#<title>(.*?)</title>#', self::$html, $matches ) && isset( $matches[1] ) )
					self::$nomeSite = trim( $matches[1] );
			break;
		}
			
		self::$nomeSite = self::esc( self::$nomeSite );
		self::$titulo = ( self::$nomeSite ? self::$nomeSite . "&ensp;&diam;&ensp;" : '' ) . ( self::$framework ? self::$framework . ' ' : '' ) . 'Console';

	}
	
	static public function exec() {
	
		// Executa o comando entrado ou mostra uma mensagem estática
	
		if ( self::$erro ) {
		
			print trim( self::$erro );
			
		} else {

			if ( self::$comando ) {

				// Executa o comando e captura o output
				ob_start();
				eval( self::$comando );
				$resultado = ob_get_contents();
				ob_end_clean();
				
				print $resultado === ''
					// Se não houver output (ex. nenhum comando print), dá uma mensagem padrão
					? 'Script executado.'
					// Se houver, escapa o HTML gerado para não quebrar a página
					: self::esc( $resultado )
				;

			} else {
			
				print 'Aguardando...';
			
			}
		
		}
	
	}

}

// Inicialização

WPC::init();

// Inclui o framework no escopo global

try {

	// Certos frameworks requerem mais do que um simples include

	switch ( WPC::$framework ) {
	
		case 'Magento' :

			include WPC::$arquivoInclude;
			umask(0);
			Mage::app();
		
		break;
		case 'Joomla' :
		
			define( '_JEXEC', 1 );
			define( '_VALID_MOS', 1 );
			define( 'JPATH_BASE', WPC::$incPath );
			define( 'DS', DIRECTORY_SEPARATOR );
			include JPATH_BASE .DS.'includes'.DS.'defines.php';
			include JPATH_BASE .DS.'includes'.DS.'framework.php';
			$GLOBALS['mainframe'] =& JFactory::getApplication('site');
			$GLOBALS['mainframe']->initialise();
		
		break;
		case 'WordPress' :
		
			include WPC::$arquivoInclude;
		
		break;
		case '' :
		
			// Nenhum arquivo
		
		break;
		default :
	
			// Descarta qualquer HTML gerado, só queremos que execute o PHP
			ob_start();
			include WPC::$arquivoInclude;
			WPC::$html = ob_get_contents();
			ob_end_clean();
			
		break;
	
	}

} catch ( Exception $WPC_excecao ) {

	WPC::$erro .= $WPC_excecao->getMessage() . PHP_EOL;

}

// Depois de incluso, roda os passos finais

WPC::postInit();

// Define as funções de ajuda

if ( !function_exists( 'ln' ) ) {

	function ln() {
		// Imprime todos os argumentos convertidos em strings, dando quebras de linha entre cada print
		// @requer toString
		$args = func_get_args();
		foreach ( $args as $string )
			print toString( $string ) . PHP_EOL;
	}

}

if ( !function_exists( 'toString' ) ) {

	function toString( $var ) {
		// Converte valores em uma string
		if ( is_string( $var ) )
			return $var;
		if ( is_numeric( $var ) )
			return (string) $var;
		if ( is_array( $var ) )
			return json_encode( $var );
		if ( is_object( $var ) )
			return get_class( $var );
		if ( is_null( $var ) )
			return 'NULL';
		if ( is_bool( $var ) )
			return $var
				? 'TRUE'
				: 'FALSE'
			;
		return gettype( $var );
	}

}

// HTML, é a sua vez!

?>
<!doctype html>
<html>
<head>

	<meta charset="utf-8">
	<title><?php print WPC::$titulo ?></title>
	
	<link rel="shortcut icon" type="image/png" href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA2klEQVQ4T2MYzsCdoYShnGEvgwNDDlSEBBDLMAsI3zBMY3gGpkMZeqEyRIBchs1gTW0MVxhUGKwYJjE8AfNBhhIEhQy7wYpBmhQYjMBiFgzRcJdkMqwFi2EAdiCsZTgDVgRSDNKEDEBeAMmBMMgSDAAKKJgtIIPQAQfQgi6GO3ALjBmCoTJIwBUY6jBDUhmWQkUhoJLhCFgc5DV016EAkCQs0GAhDwvUPoZ74EAlCECKQIpBrikFpgOQZlCMwAKVKABSDNIE0wwKA5IBH4MQQxjQG6AYGsSAgQEA6olONcGiOGIAAAAASUVORK5CYII=">

	<style>
	
		* {
			-webkit-box-sizing: border-box;
			-moz-box-sizing: border-box;
			box-sizing: border-box;
			-moz-tab-size: 4;
			tab-size: 4;
		}
		
		::selection {
			background: #0c0;
			color: black;
		}
		
		::-moz-selection {
			background: #0c0;
			color: black;
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
			text-align: center;
		}
	
		h1 {
			margin: 2em 0 1em;
			text-align: center;
			font-size: 24px;
			color: #090;
		}
		
		select,
		textarea,
		input[type=text] {
			-webkit-appearance: none;
			-moz-appearance: none;
			outline: none;
			margin: 8px 0;
			width: 100%;
			border: 4px solid #090;
			background: black;
			box-shadow: none;
			padding: 0.5em;
			font: inherit;
			color: inherit;
		}
		
		textarea {
			height: 16em;
		}
		
		select#diretorio {
			width: calc( 50% - 4px );
			margin-right: 4px;
			cursor: pointer;
		}
		
		input#include {
			width: calc( 50% - 4px );
			margin-left: 4px;
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
				background-color: #090 !important;
			}
		
		pre {
			margin: 8px 0;
			width: 100%;
			border: 4px solid #090;
			background: black;
			padding: 0.5em;
			text-align: left;
			white-space: pre-wrap;
			font: inherit;
		}
	
	</style>
	
</head>
<body>

	<div class="page">
		
		<form action="<?php print $_SERVER['PHP_SELF'] ?>" method="post" accept-charset="utf-8" enctype="application/x-www-form-urlencoded">

			<h1>&ensp;&diam;&ensp;<?php print WPC::$titulo ?>&ensp;&diam;&ensp;</h1>
		
			<textarea name="comando"><?php if ( WPC::$comando ) print WPC::esc( WPC::$comando ); ?></textarea>
			
			<button type="submit">Executar</button><br>
			
			<select id="diretorio" name="diretorio" title="Diretório de trabalho">
				<?php print WPC::$listaDiretorios ?>
			</select><!--
				(remove o espaço entre os dois blocos inline para que caibam lado a lado)
			--><input id="include" name="include" type="text" value="<?php print WPC::esc( WPC::$include ) ?>" title="Arquivo de include a ser carregado">
			
			<script>
			
				// Sem jQuery!!
				document.getElementById('diretorio').onchange = function() {
					document.getElementById('include').value = this[ this.selectedIndex ].dataset.framework;
				}
			
			</script>
			
			<!-- Temos que definir tudo o que é importante antes da execução, porque se houver um erro fatal, nada será renderizado depois desse ponto -->
			
			<pre title="Resultado da execução"><?php
				WPC::exec();
			?></pre>
		
		</form>
	
	</div>

	<!-- Ahh, acabou :-( -->
	
</body>
</html>