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

	if ( !is_user_logged_in() && isset( $wp_query->query_vars['confirmar'] ) ) {
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
					'url_login' => site_url( '/conta' ),
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
					erro( "Este e-mail já foi confirmado. Se você esqueceu sua senha, <a href='" . site_url('wp-login.php?action=lostpassword' ) . ">solicite a troca</a>." );
					break;
				}
				enviarConfirmacaoEmail( $user );
				msg( 'Enviamos um e-mail para sua conta contendo um link de confirmação.' );
			} while(0);
		}
		
	}
	
}

get_header();

?>

<div id="primary" class="site-content">

    <div id="content" class="table-responsive" role="main">

	
	
		<h1 class="entry-title">Sua Conta</h1>
		<span class="arrow-w"></span>
		<p>&nbsp;</p>
		
		<?php imprimirMensagens(); ?>



		<?php switch ( $tela ) :
			case 'confirmar' : ?>

			
			
				<h2>Confirme Seu E-mail</h2>
				
				<p>Você deve confirmar seu e-mail para ativar sua conta.</p>
				
				<form id="form-confirmacao" action="<?php print home_url('/conta/confirmar') ?>" method="POST">
				
					<div class="form-group">
						<label for="form-email" class="obrigatorio">E-mail:</label>
						<input id="form-email" name="email" type="email" class="form-control">
					</div>
					
					<button type="submit" class="btn btn-primary">Enviar</button>
				
				</form>
			
			
			
			<?php break; ?>
			<?php case 'login' : ?>
			
			
			
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
				
				<p>Por favor, faça o login no formulário no topo da página com seu e-mail se senha.</p>
				
				<p>Caso tenha perdido sua senha, <a href="<?php print site_url('wp-login.php?action=lostpassword') ?>">clique aqui</a>.</p>
			
			
			
			<?php break; ?>
			<?php case 'conta' : ?>

			
			
				<?php
				$user = obterUsuario();
				$user_funcao = funcaoDesteUsuario( $user );
				$primeiro_login = get_user_meta( $user->ID, 'primeiro_login', true );
				if ( $primeiro_login ) {
					print '<p class="info primeiro-login">Se deseja trocar sua senha, <a href="' . site_url('/perfil') . '">acesse seu perfil clicando aqui</a>.</p>';
					delete_user_meta( $user->ID, 'primeiro_login' );
				}
				?>
				
				<p>Olá <?php print esc_html( $user->display_name ) ?>, este é o painel de sua conta.</p>
				
				<p>Para editar seus dados cadastrais, <a href="<?php print site_url('/perfil') ?>">acesse seu perfil clicando aqui</a>.</p>
			
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
						<dd><?php print obterItem( 'role_associacao', $empresa_tipo_associacao ) ?></dd>
						<dt>Expiração:</dt>
						<dd>
							<?php print formatarData( $empresa_status['expiracao'] ) ?>
							(<?php print human_time_diff( time(), $empresa_status['expiracao'] ) ?>)
						</dd>
					<?php endif; ?>
				</dl>
			
			
			
			<?php break;
		endswitch;
		?>
		
    </div><!-- END #content -->

</div><!-- END #primary -->

<?php

get_footer();

