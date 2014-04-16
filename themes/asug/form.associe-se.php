<?php

require 'definicoes.campos.php';
require 'definicoes.perfis.php';

global $prefixoMensagens;

$msg = array(
	'post_vazio'				=> 'Por favor, preencha os dados do formulário.',
	'operacao_invalida'			=> 'Operação inválida.',
	'email_pessoal'				=> 'Não utilize um e-mail pessoal para o cadastro. Utilize o e-mail com o domínio da empresa.',
	'usuario_valido'			=> 'Seus dados são válidos! Prosseguindo para a escolha de empresa&hellip;',
	'assciacao_valida'			=> 'Sua escolha foi registrada.',
);

$emailsComuns = array(
	'ig.com.br',
	'gmail.com',
	'gmail.com.br',
	'blogspot.com',
	'googlemail.com',
	'hotmail.com',
	'hotmail.com.br',
	'msn.com.br',
	'msn.com',
	'msnl.com',
	'live.com',
	'outlook.com',
	'yahoo.com',
	'yahoo.com.br',
	'rocketmail.com',
	'ymail.com',
	'ymail.com.br',
	'aol.com',
	'aol.com.br',
	'terra.com.br',
	'zaz.com.br',
	'uol.com.br',
	'uol.com',
	'bol.com.br',
	'zipmail.com.br',
	'zip.net',
	'globo.com',
	'globo.com.br',
	'globomail.com',
	'r7.com.br',
	'r7.com',
	'ig.com.br',
	'ig.com',
	'ieg.com.br',
	'igmail.com.br',
	'brturbo.com.br',
	'brturbo.com',
	'superig.com.br',
	'ibest.com.br',
	'ibestvip.com.br',
	'oi.com.br',
	'itelefonica.com.br',
	'uai.com.br',
	'uainet.com.br',
	'uaimail.com.br',
	'sky.com.br',
	'sky.com',
	'telefonica.com.br',
	'facebook.com',
);

if ( !empty( $_POST ) ) {

	obterPost( 'secao' );
	
	switch ( $_POST['secao'] ) {
	
		case 'conta' :
		
			// Verificação automatizada
			if ( !processarCampos('usuario') )
				break;
				
			$usuario_sufixo = extrairTLD( $_POST['email'] );
			
			if ( in_array( $usuario_sufixo, $emailsComuns ) ) {
				erro( $msg['email_pessoal'] );
				break;
			}
		
			msg( $msg['usuario_valido'] );
		
		break;
		case 'associacao' :
		
			// Verificação automatizada
			if ( !processarCampos('usuario') )
				break;
				
			msg( $msg['associacao_valida'] );
		
		break;
		case 'empresa' :
		
			// Verificação automatizada
			if ( !processarCampos( 'empresa', 'empresa' ) )
				break;
				
			msg( 'Os dados da empresa foram validados com sucesso. Prosseguindo para o registro de funcionários&hellip;' );
		
		break;
		default :
		
			// Representante - Verificação automatizada
			$prefixoMensagens = '[Representante 2] ';
			if ( !processarCampos( 'funcionario', 'representante' ) )
				break;
		
			// CIO - Verificação automatizada
			$prefixoMensagens = '[CIO] ';
			if ( !processarCampos( 'funcionario', 'cio' ) )
				break;
		
			// Financeiro - Verificação automatizada
			obterPost('fin_habilitar');
			if ( $_POST['fin_habilitar'] ) {
				$prefixoMensagens = '[Financeiro] ';
				if ( !processarCampos( 'funcionario', 'financeiro', true ) )
					break;
			}
		
			$prefixoMensagens = '';
			erro( $msg['operacao_invalida'] );
		
		break;
	
	}

} else {

	erro( $msg['post_vazio'] );
	
}


retornarMensagens();
