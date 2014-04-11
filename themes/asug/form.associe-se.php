<?php

require 'functions.formatacao.php';
require 'definicoes.campos.php';
require 'definicoes.perfis.php';

$msg = array(
	'post_vazio'				=> 'Por favor, preencha os dados do formulário.',
	'operacao_invalida'			=> 'Operação inválida.',
);

if ( !empty( $_POST ) ) {

	obterPost( 'secao' );
	
	switch ( $_POST['secao'] ) {
	
		case 'conta' :
		
			// Verificação automatizada
			if ( !processarCampos('usuario') )
				break;
		
			erro( 'Chegou aqui.' );
		
		break;
		case 'empresa' :
		
		
		break;
		default :
		
			erro( $msg['operacao_invalida'] );
		
		break;
	
	}

} else {

	erro( $msg['post_vazio'] );
}


retornarMensagens();
