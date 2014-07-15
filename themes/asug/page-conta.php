<?php
/*
 * Página de Minha Conta e funções relacionadas
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

 
 
global $mensagens;
 
require_once TEMPLATEPATH . '/inc/config-associacao.php';
 
$tela = 'conta';



if ( is_user_logged_in() ) {

	// Deixa entrar na conta

} else {

	// Mostrar login por default
	
	$tela = 'login';

	// Confirmação de e-mail

	if ( isset( $wp_query->query_vars['confirmar'] ) ) {
		// Verifica por um código postado
		$codigo = $wp_query->query_vars['confirmar'];
		if ( $codigo ) {
			// Está correto?
			if ( $user_id = confirmarEmail( $codigo ) ) {
				// Sim! Ir para o login
				$tela = 'login';
				// Gera uma senha e salva no perfil
				$senha = gerarSenha();
				/*
				wp_update_user( array(
					'ID' => $user_id,
					'user_pass' => $senha,
				) );
				*/
				wp_set_password( $senha, $user_id );
				// Verifica o status
				$user = get_userdata( $user_id );
				$user_ativo = usuarioEstaAtivo( $user );
				// Envia por e-mail
				$tokens = array(
					'senha' => $senha,
				);
				enviarEmailPadronizado(
					$user,
					'conta_confirmada_' . ( $user_ativo ? 'ativa' : 'inativa' ),
					$tokens
				);
				$mensagens = array();
				// Sincroniza na SAP
				$perfil = perfilUsuario( $user );
				sap_sincronizarUsuario( $perfil );
				// Mensagem
				msg('Seu e-mail foi confirmado! Um outro e-mail foi enviado com seus dados de login.');
			} else {
				// Não...
				$tela = 'confirmar';
				// As mensagens de erro são criadas pela função confirmarEmail()
			}
		} else {
			$tela = 'confirmar';
		}
		// Solicitação de confirmação
		if ( obterPost('email') ) {
			do {
				if ( !validarEmail( $_POST['email'] ) ) {
					erro( 'O e-mail digitado não é válido.' );
					break;
				}
				$user = get_user_by( 'email', $_POST['email'] );
				if ( !$user ) {
					erro( "Não existe nenhum usuário cadastrado com o e-mail \"$_POST[email]\"." );
					break;
				}
				$confirmado = get_user_meta( $user->ID, 'email_confirmado', true );
				if ( $confirmado ) {
					erro( "Este e-mail já foi confirmado. Se você esqueceu sua senha, <a href='" . site_url('wp-login.php?action=lostpassword' ) . "'>solicite a troca</a>." );
					break;
				}
				enviarConfirmacaoEmail( $user );
				msg( 'Enviamos um e-mail para sua conta contendo um link de confirmação.' );
			} while(0);
		}
		
	}
	
}

// Tela de login redireciona para o wp-login

if ( 'login' == $tela ) {
	wp_redirect( wp_login_url() );
	exit;
}


/*
// Mensagens redirecionadas da página de login do WP

if ( $string = obter( $_SESSION, 'erros' ) ) {
	erro( $string );
	unset( $_SESSION['erros'] );
}
	
if ( $string = obter( $_SESSION, 'mensagens' ) ) {
	msg( $string );
	unset( $_SESSION['mensagens'] );
}
*/

get_header();

?>

<div id="primary" class="site-content">

    <div id="content" class="table-responsive" role="main">

	
	
		<style>
	
			h2 {
				margin-top: 30px;
				margin-bottom: 20px;
			}

			#main p {
				padding: 0;
			}
			
			.form-group {
				margin-top: 10px;
			}
			
			#main input[type=text],
			#main input[type=email] {
				display: inline-block;
				margin: 0 10px;
				width: 300px;
				padding: 2px 4px;
			}
		
		</style>
	
		<h1 class="entry-title">Sua Conta</h1>
		<span class="arrow-w"></span>
		
		<?php imprimirMensagens(); ?>



		<?php switch ( $tela ) :
			case 'confirmar' : ?>

			
			
				<h2>Confirmação de E-mail</h2>
				
				<p>Você deve confirmar seu endereço de e-mail para que sua conta seja ativada.</p>
				
				<p>Digite seu e-mail abaixo para solicitar uma nova confirmação:</p>
				
				<form id="form-confirmacao" action="<?php print home_url('/conta/confirmar') ?>" method="POST">
				
					<div class="form-group">
					
						<label for="form-email" class="obrigatorio">Seu e-mail:</label>
						<input id="form-email" name="email" type="email" class="form-control">
						
						<button type="submit" class="btn btn-primary">Solicitar</button>
						
					</div>
				
				</form>
			
			
			
			<?php break; ?>
			<?php case 'login' : // Não mais utilizado ?>
			
			
			
				<h2>Login</h2>
				
				<?php /*
				wp_login_form( array(
					'echo'           => true,
					'redirect'       => home_url('conta'), 
					'form_id'        => 'loginform',
					'label_username' => 'Usuário',
					'label_password' => 'Senha',
					'label_remember' => 'Lembrar',
					'label_log_in'   => 'Login',
					'id_username'    => 'user_login',
					'id_password'    => 'user_pass',
					'id_remember'    => 'rememberme',
					'id_submit'      => 'wp-submit',
					'remember'       => true,
					'value_username' => NULL,
					'value_remember' => false
				) );
				*/ ?>
				
				<p>Por favor, faça o login no formulário no topo da página com seu e-mail e senha.</p>
				
				
				
				<h2>Recuperar Senha</h2>
				
				<p>Caso tenha perdido sua senha, preencha o formulário abaixo.</p>

				<form name="lostpasswordform" id="lostpasswordform" action="<?php echo esc_url( site_url( 'wp-login.php?action=lostpassword', 'login_post' ) ); ?>" method="post" role="form">
				
					<div class="form-group">
						<label for="user_login">Seu e-mail:</label>
						<input type="text" name="user_login" id="user_login" class="form-control" value="<?php echo esc_attr($user_login); ?>">
						<button type="submit" name="wp-submit" id="wp-submit" class="btn btn-primary"><?php esc_attr_e('Get New Password'); ?></button>
					</div>
					
					<input type="hidden" name="redirect_to" value="" />
					
				</form>
			
			
			
			<?php break; ?>
			<?php case 'resetar' : ?>
			
			
			
			
			
			
			
			<?php break; ?>
			<?php case 'conta' : ?>

				<style>
				
					dt {
						clear: left;
						float: left;
						width: 100px;
						padding-right: 16px;
					}

					dd {
						float: left;
					}

					dt.logo {
						padding: 8px 0;
					}
				
				</style>
			
				<?php
				$user = obterUsuario();
				$user_funcao = funcaoDesteUsuario( $user );
				// Mensagem no primeiro login
				$primeiro_login = get_user_meta( $user->ID, 'primeiro_login', true );
				if ( $primeiro_login ) {
					print '<p class="info primeiro-login">Se deseja trocar sua senha, <a href="' . site_url('/perfil') . '">acesse seu perfil clicando aqui</a>.</p>';
					delete_user_meta( $user->ID, 'primeiro_login' );
				}
				?>
				
				<p>&nbsp;</p>
				
				<p>Olá <?php print esc_html( $user->display_name ) ?>, este é o painel de sua conta.</p>
				
				<p>Para alterar seus dados cadastrais, <a href="<?php print site_url('/perfil') ?>">acesse seu perfil clicando aqui</a>.</p>
			
				<dl>
					<dt>Sua função:</dt>
					<dd><?php print obterItem( 'funcoes', $user_funcao ) ?></dd>
					<?php if ( $user_funcao == FUNCAO_FUNCIONARIO || $user_funcao == FUNCAO_REPRESENTANTE ) : ?>
						<?php
						$empresa_id = get_user_meta( $user->ID, 'empresa', true );
						$empresa = get_userdata( $empresa_id );
						$empresa_tipo_associacao = get_user_meta( $empresa_id, 'tipo_associacao', true );
						$empresa_status = usuarioEstaAtivo( $empresa, true );
						?>
						<dt class="logo"><?php print get_avatar( $empresa_id, 150 ) ?></dt>
						<dd></dd>
						<dt>Empresa:</dt>
						<dd><?php print esc_html( $empresa->display_name ) ?></dd>
						<dt>Filiação:</dt>
						<dd><?php print obterItem( 'tipo_associacao', $empresa_tipo_associacao ) ?></dd>
						<dt>Expiração:</dt>
						<dd><?php print formatarData( $empresa_status['expiracao'] ) ?></dd>
					<?php endif; ?>
				</dl>
			
			
			
			<?php break;
		endswitch;
		?>
		
    </div><!-- END #content -->

</div><!-- END #primary -->

<?php

get_footer();

