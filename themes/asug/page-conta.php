<?php
/*
 * Página de Minha Conta e funções relacionadas
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

 
 
$tela = 'conta';



// Confirmação de e-mail

if ( !is_user_logged_in() && isset( $wp_query->query_vars['confirmar'] ) ) {
	// Verifica por um código postado
	$codigo = $wp_query->query_vars['confirmar'];
	if ( $codigo ) {
		// Está correto?
		if ( confirmarEmail( $codigo ) )
			// Sim! Ir para o login
			$tela = 'login';
		else
			// Não...
			$tela = 'confirmar';
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
			enviarConfirmacaoEmail( $user );
		} while(0);
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
				
				<?php
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
				?>
			
			
			
			<?php break; ?>
			<?php case 'conta' : ?>

			
			
				<?php
				$user = obterUsuario();
				$user_funcao = funcaoDesteUsuario( $user );
				?>
				
				<p>Olá <?php print esc_html( $user->display_name ) ?>, este é o painel de sua conta.</p>
			
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

