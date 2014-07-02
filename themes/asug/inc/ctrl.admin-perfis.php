<?php
/*
 * Ação do formulário de edição de perfil no frontend
 * Carregado de dentro da função que roda com a ação de salvar o perfil
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

 
 
if ( !defined('OK') )
	wp_die('Acesso restrito.');
 
$wp_error = new WP_Error();

// error_log( 'Post: ' . PHP_EOL . retornarDump( $_POST ) );

// Determina o tipo de usuário
$funcao = funcaoDesteUsuario( $usuario );

switch ( $funcao ) {
	case FUNCAO_ADMIN :
		$perfil = 'admin_edicao';
	break;
	case FUNCAO_EMPRESA :
		$perfil = 'empresa_edicao_admin';
	break;
	default :
		$perfil = 'usuario_edicao_admin';
	break;
}

$eEmpresa = $funcao == FUNCAO_EMPRESA;

// Valida
if ( !processarCampos( $perfil ) ) {
	// Erros na validação
	foreach ( $mensagens as $txt ) {
		$wp_error->add( 'invalido', $txt );
	}
	error_log( $perfil . PHP_EOL . retornarDump( $mensagens ) );
	return $wp_error;
}

// Obtém do post apenas os campos permitidos para edição
$post = sanitizarPost( $perfil, FUNC_RETURN );

// Adiciona campos faltantes
if ( $eEmpresa ) {
} else {
	$post['nome_completo'] = $_POST['nickname'];
}

// error_log( $perfil . PHP_EOL . retornarDump( $post ) );

// Salva
$retorno = atualizarUsuario( $post, ESTRUTURA_FORM, $eEmpresa );

if ( $eEmpresa ) {
	// Salva os metadados dos representantes
	processarCampos( 'funcionario_edicao_admin', 'rep2' );
	$rep2_post = sanitizarPost( 'funcionario_edicao_admin', FUNC_RETURN, 'rep2' );
	// error_log( 'Rep2' . PHP_EOL . retornarDump( $rep2_post ) );
	update_user_meta( $post['user_id'], 'representante2', $rep2_post );
	processarCampos( 'funcionario_edicao_admin', 'cio' );
	$cio_post = sanitizarPost( 'funcionario_edicao_admin', FUNC_RETURN, 'cio' );
	// error_log( 'CIO' . PHP_EOL . retornarDump( $cio_post ) );
	update_user_meta( $post['user_id'], 'cio', $cio_post );
	processarCampos( 'funcionario_edicao_admin', 'fin' );
	$fin_post = sanitizarPost( 'funcionario_edicao_admin', FUNC_RETURN, 'fin' );
	// error_log( 'Fin' . PHP_EOL . retornarDump( $fin_post ) );
	update_user_meta( $post['user_id'], 'financeiro', $fin_post );
}

// error_log( $retorno ? 'Salvo' : 'Falha' );

// Remove o código de confirmação anterior
// if ( $post['email_confirmado'] )
// delete_transient( $usuario->user_nicename . '_confirmacao_email' );

// Fim
return true;
