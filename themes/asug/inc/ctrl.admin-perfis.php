<?php
/*
 * Ação do formulário de edição de perfil no frontend
 * Carregado de dentro da função que roda com a ação de salvar o perfil
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

 
 
if ( !defined('OK') )
	wp_die('Acesso restrito.');
 
require_once TEMPLATEPATH . '/inc/config-associacao.php';

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
	// error_log( $perfil . PHP_EOL . retornarDump( $mensagens ) );
	return;
}

// Obtém do post apenas os campos permitidos para edição
$post = sanitizarPost( $perfil, FUNC_RETURN );

// Adiciona campos faltantes
$post['nome_completo'] = $_POST['first_name'] . ' ' . $_POST['last_name'];

if ( $eEmpresa ) {
	// Representante 1
	processarCampos( array( 'user_id' => 1 ), 'rep1' );
	$representante1_atual = get_user_meta( $post['user_id'], 'representante1', true );
	$representante1_novo = $_POST['rep1_user_id'];
	if ( $representante1_atual != $representante1_novo ) {
		// Verifica se o representante novo pertence à empresa
		$representante1_empresa = (int) get_user_meta( $representante1_novo, 'empresa', true );
		if ( $representante1_empresa != $post['user_id'] ) {
			return erro( 'O ID dado para o representante nº1 não pertence a um associado que está filiado à empresa.' );
		}
		// Troca de representante
		wp_update_user( array(
			'ID' => $representante1_atual,
			'role' => obterItem( 'role_funcao', FUNCAO_FUNCIONARIO ),
		) );
		wp_update_user( array(
			'ID' => $representante1_novo,
			'role' => obterItem( 'role_funcao', FUNCAO_REPRESENTANTE ),
		) );
		// Atualiza o meta da empresa
		update_user_meta( $post['user_id'], 'representante1', $_POST['rep1_user_id'] );
		// TO-DO atualizar no SAP dados do representante e o nome do rep em todos os associados
	}
} else {
	if ( !get_user_meta( $post['user_id'], 'email_confirmado', true ) && $_POST['email_confirmado'] ) {
		// Primeira ativação
		primeiraAtivacao( $post['user_id'] );
		if ( $codigo = get_user_meta( $post['user_id'], 'codigo_confirmacao', true ) ) {
			$transient_chave = "codigo_confirmacao_$codigo";
			delete_transient( $transient_chave );
			delete_user_meta( $post['user_id'], 'codigo_confirmacao' );
			delete_user_meta( $post['user_id'], 'hora_confirmacao' );
		}
	}
}

// error_log( $perfil . PHP_EOL . retornarDump( $post ) );

// Salva2
$retorno = atualizarUsuario( $post, ESTRUTURA_FORM, $eEmpresa );

if ( $eEmpresa ) {
	// Salva os metadados dos representantes
	// Representante 2
	processarCampos( 'funcionario_edicao_admin', 'rep2' );
	$rep2_post = sanitizarPost( 'funcionario_edicao_admin', FUNC_RETURN, 'rep2' );
	// error_log( 'Rep2' . PHP_EOL . retornarDump( $rep2_post ) );
	update_user_meta( $post['user_id'], 'representante2', $rep2_post );
	// CIO
	processarCampos( 'funcionario_edicao_admin', 'cio' );
	$cio_post = sanitizarPost( 'funcionario_edicao_admin', FUNC_RETURN, 'cio' );
	// error_log( 'CIO' . PHP_EOL . retornarDump( $cio_post ) );
	update_user_meta( $post['user_id'], 'cio', $cio_post );
	// Financeiro
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
