<?php
/*
 * Customiza a página de login
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */
 
 
 
// Redirecionamento da página de login do WP
 
 
 
/*
function filter_errosLogin( $erros = null ) {
	// Captura as mensagens ou erros e redireciona para a página refeita de login
	if ( is_wp_error( $erros ) ) {
		$_SESSION['mensagens'] = '';
		$_SESSION['erros'] = '';
		foreach ( $erros->get_error_codes() as $code ) {
			$severity = $erros->get_error_data($code);
			foreach ( $erros->get_error_messages($code) as $msg ) {
				if ( 'message' == $severity )
					$_SESSION['mensagens'] .= $msg . "\n";
				else
					$_SESSION['erros'] .= $msg . "\n";
			}
		}
	} elseif ( is_string( $erros ) ) {
		$_SESSION['erros'] = $erros;
	}
	wp_redirect( site_url('/conta') );
	exit();
}

function filter_mensagensLogin( $msgs ) {
	// Captura as mensagens e redireciona para a página refeita de login
	if ( is_string( $msgs ) ) {
		$_SESSION['mensagens'] = $msgs;
	}
	wp_redirect( site_url('/conta') );
	exit();
}

// Intercepta as mensagens no header da página de login
add_filter( 'login_errors', 'filter_errosLogin', 1, 1 );
add_filter( 'login_messages', 'filter_errosLogin', 1, 1 );

// Intercepta a ação de login, especificamente, antes do header
add_filter( 'wp_login_errors', 'filter_errosLogin', 1, 1 );

function action_senhaPerdida() {
	// Redireciona para a página refeita de login
	wp_redirect( site_url('/conta') );
	exit();
}

// add_action( 'login_form_lostpassword', 'action_senhaPerdida' );
// add_action( 'login_form_retrievepassword', 'action_senhaPerdida' );
// add_action( 'lost_password', 'action_senhaPerdida' );

function action_formLogin() {
	// Redireciona para a página refeita de login se não há dados a processar numa ação permitida
	// (consequentemente, a função de interceptar mensagens que roda mais tarde não seria chamada)
	$action = isset($_REQUEST['action'])
		? $_REQUEST['action']
		: 'login'
	;
	// Determina as ações e condições a permitir
	switch ( $action ) {
		case 'postpass' :
		case 'logout' :
		case 'lostpassword' :
		case 'retrievepassword' :
		case 'resetpass' :
		case 'rp' :
			return;
		break;
		case 'login' :
			if ( !empty( $_POST ) )
				return;
		break;
		case 'register' :
		default :
			// Negar
		break;
	}
	wp_redirect( site_url('/conta') );
	exit();
}

add_action( 'login_init', 'action_formLogin' );
*/



// Personalização da página de login do WP



function action_loginBeginHeader() {
	// Se logado, redireciona
	if ( is_user_logged_in() )
		wp_redirect( site_url('/conta') );
	// Inicia is_user_logged_in() )a captura o header gerado no wp-login para eliminá-lo
	ob_start();
}

function action_loginEndHeader() {
	// Elimina o header original que foi capturado
	ob_end_clean();
	// Inicia a captura do conteúdo da página wp-login
	ob_start();
}

function filter_loginEndHeader( $valor ) {
	// Roda o fechamento do header no momento apropriado, antes da saída de mensagens
	action_loginEndHeader();
	return $valor;
}

add_action( 'login_init', 'action_loginBeginHeader' );
// add_action( 'login_head', 'action_loginEndHeader' );
add_filter( 'login_message', 'filter_loginEndHeader' );

function action_loginFooter() {
	// Salva o conteúdo da página
	$conteudo = ob_get_contents();
	ob_end_clean();
	// Determina a ação da página
	$action = isset($_REQUEST['action'])
		? $_REQUEST['action']
		: 'login'
	;
	// Define o subtítulo
	switch ( $action ) {
		case 'lostpassword' :
		case 'retrievepassword' :
			$subtitulo = 'Resetar Senha';
		break;
		case 'resetpass' :
		case 'rp' :
			$subtitulo = 'Nova Senha';
		break;
		case 'postpass' :
		case 'logout' :
		case 'register' :
			// Sair sem fazer nada
			return;
		break;
		case 'login' :
		default :
			$subtitulo = 'Login';
		break;
	}
	// Monta a página com o template
	// Header
	get_header();
	?>
	
	<style>

		h2 {
			margin-top: 30px;
			margin-bottom: 20px;
		}
		
		#backtoblog,
		#nav {
			display: none;
		}
		
		.form-group {
			margin: 0px;
		}
		
		#main input[type=text],
		#main input[type=password],
		#main input[type=email] {
			display: inline-block;
			margin: 0;
			width: 300px;
			padding: 2px 4px !important;
			text-transform: none !important;
		}
		
		#main .button {
		  display: inline-block;
		  padding: 10px 16px;
		  margin-bottom: 0;
		  line-height: 1.33;
		  font-size: 18px;
		  font-weight: normal;
		  text-align: center;
		  white-space: nowrap;
		  vertical-align: middle;
		  cursor: pointer;
		  -webkit-user-select: none;
			 -moz-user-select: none;
			  -ms-user-select: none;
			   -o-user-select: none;
				  user-select: none;
		  background-image: none;
		  border: none;
		  border-radius: 6px;
		  text-transform: uppercase;
		  width: auto;
		  height: auto;
		  overflow: hidden;
		}
		
		#main .button:focus {
		  outline: thin dotted;
		  outline: 5px auto -webkit-focus-ring-color;
		  outline-offset: -2px;
		}
		
		#main .button:active,
		#main .button.active {
		  background-image: none;
		  outline: 0;
		  -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, .125);
				  box-shadow: inset 0 3px 5px rgba(0, 0, 0, .125);
		}
		
		#main .button-primary {
		  color: #fff;
		  background-color: #E57824;
		  border-color: none;
		  text-transform: uppercase;
			  -webkit-transition: all linear 0.2s;
		  -moz-transition: all linear 0.2s;
		  -ms-transition: all linear 0.2s;
		  -o-transition: all linear 0.2s;
		  transition: all linear 0.2s;
		}
		
		#main .button-primary:hover,
		#main .button-primary:focus,
		#main .button-primary:active,
		#main .button-primary.active {
		  color: #fff;
		  background-color: #222F63;
		  border-color: #285e8e;
			  -webkit-transition: all linear 0.2s;
		  -moz-transition: all linear 0.2s;
		  -ms-transition: all linear 0.2s;
		  -o-transition: all linear 0.2s;
		  transition: all linear 0.2s;
		}
		
		#main .button-primary:active,
		#main .button-primary.active {
		  background-image: none;
		}
		
	</style>
	
	<div id="primary" class="site-content">

		<div id="content" class="table-responsive" role="main">

			<h1 class="entry-title">Entrar em Sua Conta</h1>
			<span class="arrow-w"></span>
			
			<?php
			if ( $subtitulo ) {
				print '<h2>' . esc_html( $subtitulo ) . '</h2>';
			}
			?>
		
	<?php
	// Insere o conteúdo capturado
	print $conteudo;
	// Footer
	?>
	
		</div><!-- END #content -->

	</div><!-- END #primary -->
	
	<script>
	jQuery('form > p').addClass('form-group');
	jQuery('input.input').addClass('form-control');
	jQuery('input.button').addClass('btn btn-primary');
	</script>
	
	<?php
	get_footer();
}

add_action( 'login_footer', 'action_loginFooter' );

/*
function filter_login_url( $url ) {
	// Troca o URL do logo
    return get_bloginfo( 'url' );
}

add_filter( 'login_headerurl', 'filter_login_url' );

function filter_login_title( $title ) {
	// Troca o título do logo
	return get_bloginfo( 'title' );
}

add_filter( 'login_headertitle', 'filter_login_title' );

function action_login_head() {
	// Insere estilos na página
	?><style>
	
	.login h1 a {
		width: 230px;
		height: 76px;
		background-image: url('<?php print trailingslashit( get_template_directory_uri() ) ?>images/logo-asug.png');
		background-size: 230px 76px;
	}
	
	</style><?php
	// Adiciona o filtro para o nome do blog
	add_filter( 'bloginfo', 'filter_login_bloginfo', 10, 2 );
}

function filter_login_bloginfo( $value, $key = '' ) {
	// Retorna ASUG se for requisitado o título do site
	if ( $key == 'title' )
		return 'ASUG';
	else
		return $value;
}

add_action( 'login_head', 'action_login_head' );
*/

function filter_register_url( $anchor ) {
	// Troca o URL de registro
	return '<a href="' . esc_attr( home_url('associe-se/') ) . '">Associe-se</a>';
}

add_filter( 'register', 'filter_register_url' );
