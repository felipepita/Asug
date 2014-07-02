<?php
/*
 * Ação do formulário de edição de perfil no frontend
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

 
 
// Definições



global $wpdb, $perfis;

require_once TEMPLATEPATH . '/inc/config-associacao.php';

$msg = array(
	'post_vazio'				=> 'Por favor, preencha os dados do formulário.',
	'falha_db'					=> 'Ocorreu uma falha no servidor. Por favor, tente mais tarde.',
	'operacao_invalida'			=> 'Operação inválida.',
	'nonce'						=> 'Seus dados de sessão estão inválidos. Por favor, recarregue a página.',
	'sucesso'					=> 'Seu perfil foi atualizado com sucesso!',
	'senha_alterada'			=> 'Sua senha de acesso foi alterada.',
);



// Processamento


	
do {

	// Dados do post
	if ( empty( $_POST ) ) {
		erro( $msg['post_vazio'] );
		break;
	}

	// Nonce
	if ( !wp_verify_nonce( $_POST['csrfToken'], 'perfil' ) ) {
		erro( $msg['nonce'] );
		break;
	}
	
	$camposDoPerfil =& $perfis['usuario_edicao']['campos'];
	
	// Se a senha foi digitada, obriga a sua repetição
	$senhaAlterada = !vazio( $_POST['senha'] );
	
	if ( $senhaAlterada )
		$camposDoPerfil['repetir_senha'] = 1;

	// Verificação automatizada
	if ( !processarCampos('usuario_edicao') )
		break;
		
	// Obtém do post apenas os campos permitidos para edição
	$post = array_intersect_key( $_POST, $camposDoPerfil );
		
	// Previne um ID arbitrário de ser enviado no form
	$post['user_id'] = get_current_user_id();
	
	// Previne que a senha seja apagada se ela não foi digitada
	if ( !$senhaAlterada )
		unset( $post['senha'] );
		
	// Salva
	$retorno = atualizarUsuario( $post, ESTRUTURA_FORM );
	
	if ( !$retorno ) {
		erro( $msg['falha_db'] );
		break;
	}
	
	// Se a senha foi alterada, envia um e-mail
	if ( $senhaAlterada ) {
		$tokens = array(
			'senha' => $post['senha'],
		);
		enviarEmailPadronizado( $post['id'], 'senha_alterada', $tokens );		
	}

	// Sucesso
	if ( $senhaAlterada )
		msg( $msg['senha_alterada'] );
		
	msg( $msg['sucesso'] );

} while(0);

retornarMensagens();
